# placeholder-website

![preview](./placeholder-website.gif)

A simple "coming soon" placeholder website that can be configured through Docker environment variables.

[docker hub](https://hub.docker.com/r/devchew/placeholder-website)

## Configuration

The website can be customized using the following environment variables:

### Required Variables

- `PAGE_TITLE`: The title that appears in the browser tab (default: "soon")
- `HERO_TEXT`: The text that appears in the center of the page (default: "soon...")

### Optional Variables

- `ANALYTICS_SCRIPT`: The complete analytics script tag (omitted if not provided)
- `CREDITS_LINK`: The URL for the credits link in the bottom right (omitted if not provided)
- `CREDITS_LINK_TITLE`: The text for the credits link (defaults to the URL if not provided)

## Usage

### Using Docker Compose (Recommended)

1. Clone this repository
2. Copy `.env.example` to `.env` and modify the values as needed
3. Run with docker-compose:

```bash
docker-compose up -d
```

### Using Docker directly

```bash
# Build the image
docker build -t placeholder-website .

# Run with minimal configuration
docker run -d -p 80:80 \
  -e PAGE_TITLE="Your Custom Title" \
  -e HERO_TEXT="coming soon..." \
  placeholder-website

# Run with all optional features
docker run -d -p 80:80 \
  -e PAGE_TITLE="Your Custom Title" \
  -e HERO_TEXT="coming soon..." \
  -e ANALYTICS_SCRIPT='<script defer src="https://umami.is/script.js" data-website-id="your-website-id"></script>' \
  -e CREDITS_LINK="https://your-website.com" \
  -e CREDITS_LINK_TITLE="Visit our website" \
  placeholder-website
```

### Environment Variables File

Create a `.env` file in the project root:

```env
# Required
PAGE_TITLE=Your Custom Title
HERO_TEXT=coming soon...

# Optional - uncomment to enable
# ANALYTICS_SCRIPT=<script defer src="https://umami.is/script.js" data-website-id="your-website-id"></script>
# CREDITS_LINK=https://your-website.com
# CREDITS_LINK_TITLE=Visit our website
```

Then run with docker-compose to automatically load these variables.
