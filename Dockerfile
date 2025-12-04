# Dùng image nhẹ, có bash và cron
FROM ubuntu:24.04

# Cài curl và cron
RUN apt-get update && \
    apt-get install -y curl cron && \
    rm -rf /var/lib/apt/lists/*

# Copy script vào container
COPY keep_alive.sh /usr/local/bin/keep_alive.sh

# Cho phép chạy cron job mỗi 10 phút
RUN echo "*/10 * * * * root /usr/local/bin/keep_alive.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/keepalive

# Cấp quyền
RUN chmod 0644 /etc/cron.d/keepalive
RUN crontab /etc/cron.d/keepalive

# Tạo log file
RUN touch /var/log/cron.log

# Chạy cron ở foreground để Render coi là service đang chạy
CMD ["cron", "-f"]
