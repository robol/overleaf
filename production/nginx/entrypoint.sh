#!/bin/sh
set -e

CONF_FILE="/etc/nginx/conf.d/clsi_proxy.conf"

echo "----------------------------------------------------"
echo "Entrypoint: Initializing clsi_proxy.conf"
echo "CLSI_POOL variable: $CLSI_POOL"

# Start the upstream block
echo "upstream backend_clsi {" > $CONF_FILE

if [ -z "$CLSI_POOL" ]; then
    echo "DEBUG: No CLSI_POOL detected. Defaulting to clsi."
    echo "  server clsi:3013;" >> $CONF_FILE
else
    # Split by comma and loop
    # Using 'tr' to replace commas with spaces for the loop
    for host in $(echo $CLSI_POOL | tr "," " "); do
        echo "DEBUG: Adding server to pool -> $host:3013"
        echo "  server $host:3013;" >> $CONF_FILE
    done
fi

# Append the remaining configuration
cat <<EOF >> $CONF_FILE
  hash \$request_uri;
}

# Define a log format that includes the upstream server address
log_format upstream_logging '\$remote_addr - \$remote_user [\$time_local] '
                            '"\$request" \$status \$body_bytes_sent '
                            '"\$http_referer" "\$http_user_agent" '
                            'upstream clsi proxy: \$upstream_addr';

server {
    listen 3013;
    server_name clsi-pool;

    access_log /var/log/nginx/access.log upstream_logging;

    location / {
        proxy_pass http://backend_clsi;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
EOF

echo "DEBUG: clsi_proxy.conf generation complete."
echo "----------------------------------------------------"

# Hand off execution to Nginx
exec nginx -g 'daemon off;'
