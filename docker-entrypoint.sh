#!/bin/bash

# Set default values if environment variables are not provided
PAGE_TITLE=${PAGE_TITLE:-"soon"}
HERO_TEXT=${HERO_TEXT:-"soon..."}

# Calculate the length of the hero text for the CSS animation
export HERO_TEXT_LENGTH=${#HERO_TEXT}

# Create a temporary file to build the HTML
cp /usr/share/nginx/html/index.html.template /tmp/index.html.temp

# Replace basic variables
envsubst '${PAGE_TITLE},${HERO_TEXT},${HERO_TEXT_LENGTH}' < /tmp/index.html.temp > /tmp/index.html.temp2

# Handle optional ANALYTICS_SCRIPT
if [ -n "$ANALYTICS_SCRIPT" ]; then
    # Replace placeholder with the provided analytics script
    ANALYTICS_SCRIPT_ESCAPED=$(printf '%s\n' "$ANALYTICS_SCRIPT" | sed 's/[[\.*^$()+?{|]/\\&/g')
    sed "s|\${ANALYTICS_SCRIPT}|$ANALYTICS_SCRIPT_ESCAPED|g" /tmp/index.html.temp2 > /tmp/index.html.temp3
else
    # Remove the analytics script line
    sed 's|${ANALYTICS_SCRIPT}||g' /tmp/index.html.temp2 > /tmp/index.html.temp3
fi

# Handle optional CREDITS_LINK
if [ -n "$CREDITS_LINK" ]; then
    # Use custom title if provided, otherwise default to the URL
    CREDITS_TITLE=${CREDITS_LINK_TITLE:-$CREDITS_LINK}
    # Escape special characters for sed
    CREDITS_LINK_ESCAPED=$(printf '%s\n' "$CREDITS_LINK" | sed 's/[[\.*^$()+?{|]/\\&/g')
    CREDITS_TITLE_ESCAPED=$(printf '%s\n' "$CREDITS_TITLE" | sed 's/[[\.*^$()+?{|]/\\&/g')
    # Replace placeholder with actual link
    sed "s|\${CREDITS_SECTION}|<a href=\"$CREDITS_LINK_ESCAPED\" class=\"credits\">$CREDITS_TITLE_ESCAPED</a>|g" /tmp/index.html.temp3 > /usr/share/nginx/html/index.html
else
    # Remove the credits section
    sed 's|${CREDITS_SECTION}||g' /tmp/index.html.temp3 > /usr/share/nginx/html/index.html
fi

# Clean up temporary files
rm -f /tmp/index.html.temp /tmp/index.html.temp2 /tmp/index.html.temp3

# Start nginx
exec "$@"
