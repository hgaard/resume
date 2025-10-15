#!/bin/bash
set -e

# Script to generate PDF from Jekyll site
# Works both locally (macOS/Linux) and in GitHub Actions

# Detect bundle command (use Homebrew Ruby on macOS if available)
if [ -f "/opt/homebrew/opt/ruby/bin/bundle" ]; then
    BUNDLE="/opt/homebrew/opt/ruby/bin/bundle"
elif command -v bundle &> /dev/null; then
    BUNDLE="bundle"
else
    echo "❌ Error: bundler not found"
    exit 1
fi

echo "🔨 Building Jekyll site..."
$BUNDLE exec jekyll build

echo "🔍 Detecting Chrome/Chromium binary..."

# Detect Chrome binary based on platform
if [ -f "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]; then
    # macOS
    CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    echo "✅ Found Google Chrome (macOS)"
elif command -v chromium-browser &> /dev/null; then
    # Linux (GitHub Actions)
    CHROME="chromium-browser"
    echo "✅ Found Chromium (Linux)"
elif command -v chromium &> /dev/null; then
    # Alternative Linux
    CHROME="chromium"
    echo "✅ Found Chromium"
elif command -v google-chrome &> /dev/null; then
    # Linux with Google Chrome
    CHROME="google-chrome"
    echo "✅ Found Google Chrome (Linux)"
else
    echo "❌ Error: Chrome or Chromium not found"
    echo "Please install Google Chrome or Chromium"
    exit 1
fi

# Set output filename (default: jakob-cv.pdf)
OUTPUT_FILE="${1:-jakob-cv.pdf}"

echo "📄 Generating PDF: $OUTPUT_FILE"

# Generate PDF with same flags as GitHub Actions
"$CHROME" \
    --headless=new \
    --disable-gpu \
    --no-sandbox \
    --disable-dev-shm-usage \
    --run-all-compositor-stages-before-draw \
    --print-to-pdf="$OUTPUT_FILE" \
    --no-pdf-header-footer \
    --print-to-pdf-no-header \
    "file://$(pwd)/_site/index.html"

if [ -f "$OUTPUT_FILE" ]; then
    FILE_SIZE=$(ls -lh "$OUTPUT_FILE" | awk '{print $5}')
    echo "✅ PDF generated successfully: $OUTPUT_FILE ($FILE_SIZE)"
else
    echo "❌ Error: PDF generation failed"
    exit 1
fi
