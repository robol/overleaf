FROM nginx:alpine

# Install tr (usually included in alpine)
RUN apk add --no-cache bash

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy static configuration files
COPY ./overleaf.conf /etc/nginx/conf.d/default.conf
COPY ./clsi.conf /etc/nginx/conf.d/clsi.conf

# Create directories for the volumes you mentioned 
# (These will be empty until mounted, but it's good practice)
RUN mkdir -p /overleaf/services/web/public \
             /overleaf/services/clsi/output

# Copy and set up the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use the script to launch Nginx
ENTRYPOINT ["/entrypoint.sh"]
