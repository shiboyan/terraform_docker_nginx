FROM nginx:latest

RUN sed -i 11i"\    autoindex on;" /etc/nginx/conf.d/default.conf && \
    sed -i 12i"\    default_type text/plain;" /etc/nginx/conf.d/default.conf

HEALTHCHECK --interval=10s --timeout=2s --retries=12 \
            CMD curl --silent --fail localhost:80 || exit 1