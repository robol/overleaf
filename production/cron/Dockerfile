# Use a lightweight base image
FROM ubuntu:22.04

# 1. Install cron and any dependencies your scripts need
RUN apt-get update && apt-get install -y cron curl && rm -rf /var/lib/apt/lists/*

# 2. Create directory for your scripts
WORKDIR /app
COPY scripts/ /app/scripts/
RUN chmod +x /app/scripts/*.sh

# 3. Copy your crontab files into the cron.d directory
# Files in /etc/cron.d/ must follow the root crontab format
COPY crontabs/ /etc/cron.d/

# 4. Give execution rights on the cron jobs and apply them
RUN chmod 0644 /etc/cron.d/* && \
    /usr/bin/crontab /etc/cron.d/*

# Add the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# The JSON form to satisfy the warning and handle signals
ENTRYPOINT ["/entrypoint.sh"]
