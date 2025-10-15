# Jakob Højgaard's CV

A curriculum vitae maintained in plain text and rendered to HTML and PDF using CSS.

Built with Jekyll and GitHub Pages. Based on the [markdown-cv](http://elipapa.github.io/markdown-cv) template.

***

## Development Setup

This repository uses Jekyll with GitHub Pages gem to maintain consistency between local development and GitHub Pages deployment.

### Prerequisites

- Ruby 3.0 or higher (Homebrew Ruby recommended on macOS)
- Bundler

### Initial Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd resume
   ```

2. Install dependencies:
   ```bash
   # If behind a corporate proxy (e.g., Netskope), export the certificate:
   security find-certificate -a -c "certadmin" -p > /tmp/netskope.pem
   cat /opt/homebrew/etc/openssl@3/cert.pem >> /tmp/netskope.pem
   export SSL_CERT_FILE=/tmp/netskope.pem

   # Install gems
   /opt/homebrew/opt/ruby/bin/bundle install
   ```

### Local Development

1. Start the Jekyll development server:
   ```bash
   # If behind corporate proxy, set certificate:
   export SSL_CERT_FILE=/tmp/netskope.pem

   # Start server
   /opt/homebrew/opt/ruby/bin/bundle exec jekyll serve
   ```

2. Open your browser to [http://localhost:4000](http://localhost:4000)

3. Edit [index.md](index.md) to update your CV content. The site will automatically rebuild when you save changes.

### Updating Dependencies

To update to the latest GitHub Pages compatible versions:

```bash
# Update gems
export SSL_CERT_FILE=/tmp/netskope.pem  # If needed
/opt/homebrew/opt/ruby/bin/bundle update

# Test the site
/opt/homebrew/opt/ruby/bin/bundle exec jekyll serve
```

### Deployment

This site is deployed via GitHub Pages. To publish changes:

1. Commit your changes to the `gh-pages` branch:
   ```bash
   git add .
   git commit -m "Update CV"
   git push origin gh-pages
   ```

2. GitHub Pages will automatically build and deploy your site within a few minutes.

3. **Automated PDF Generation**: A GitHub Action will automatically:
   - Build the Jekyll site
   - Generate `jakob-cv.pdf` from the HTML using headless Chrome
   - Commit and push the updated PDF if the content changed

4. Visit your live site at the configured GitHub Pages URL.

You can monitor the PDF generation at the [GitHub Actions page](https://github.com/hgaard/resume/actions).

### Generating a PDF Manually (Local)

If you want to generate the PDF locally without waiting for GitHub Actions:

1. Start the local server (see Local Development above)
2. Open [http://localhost:4000](http://localhost:4000) in your browser
3. Press <kbd>⌘</kbd> + <kbd>P</kbd> (macOS) or <kbd>Ctrl</kbd> + <kbd>P</kbd> (Windows/Linux)
4. In the print dialog:
   - **Uncheck "Headers and footers"** to remove date, title, URL, and page numbers
   - Set margins as desired (0.5cm recommended)
   - Choose A4 or Letter paper size
5. Save as PDF - name it `jakob-cv.pdf` to replace the existing one

The print CSS includes `@page` rules to help suppress browser headers/footers automatically.

## Styling

The included CSS will render your CV in two styles:
s
1. `kjhealy` the original default, inspired by [kjhealy's vita
template](https://github.com/kjhealy/kjh-vita).
2. `davewhipp` is a tweaked version of `kjhealy`, with bigger fonts and dates
  right aligned.

To change the default style, simply change the variable in the
`_config.yml` file.

Any other styling is possible. More CSS style contributions and forks are welcome!

### Author

Eliseo Papa ([Twitter](http://twitter.com/elipapa)/[Github](http://github.com/elipapa)/[Website](https://elipapa.github.io)).

![Eliseo Papa](https://s.gravatar.com/avatar/eae1f0c01afda2bed9ce9cb88f6873f6?s=100)

### License

[MIT License](https://github.com/elipapa/markdown-cv/blob/master/LICENSE)
