FROM nginx

# Install envsubst (gettext-base package)
RUN apt-get update && apt-get install -y gettext-base && rm -rf /var/lib/apt/lists/*

# Copy the template and entrypoint script
COPY src/index.html.template /usr/share/nginx/html/
COPY docker-entrypoint.sh /docker-entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /docker-entrypoint.sh

# Set environment variables with default values
ENV PAGE_TITLE="soon"
ENV HERO_TEXT="soon..."

# Set the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]