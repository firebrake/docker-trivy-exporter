# Copyright (C) 2023 Jérémy WALTHER <jeremy.walther@firebrake.fr> & FIREBRAKE SAS.
# trivy-exporter is licensed under the terms of the AGPL-3.0-only license.
# See <https://github.com/firebrake/docker-trivy-exporter> or README.md file for details.

FROM alpine:3.18
ARG TRIVY_VERSION=0.41.0
RUN set -ex; \
    apk add --no-cache bash coreutils curl docker-cli envsubst jq nginx supervisor tar; \
    cd /root; \
    curl -sSL https://github.com/aquasecurity/trivy/releases/download/v${TRIVY_VERSION}/trivy_${TRIVY_VERSION}_Linux-64bit.tar.gz -o trivy.tar.gz; \
    tar -xvf trivy.tar.gz; \
    mv trivy /usr/local/bin/trivy; \
    rm -rf *; \
    mkdir -p /trivy-exporter /var/log/supervisor; \
    touch /trivy-exporter/metrics;
COPY compute            /usr/local/bin/trivy-exporter-compute
COPY crontab.tpl        /trivy-exporter/crontab.tpl
COPY nginx.conf         /etc/nginx/http.d/default.conf
COPY start              /usr/local/bin/trivy-exporter-start
COPY supervisord.conf   /etc/supervisord.conf
WORKDIR /trivy-exporter
ENV TRIVY_VERSION=${TRIVY_VERSION} \
    TRIVY_EXPORTER_CACHE_REFRESH_DAYS=1 \
    TRIVY_EXPORTER_COMPUTE_CRON_MINUTES=*/5 \
    TRIVY_EXPORTER_COMPUTE_CRON_HOURS=* \
    TRIVY_EXPORTER_IMAGES_SCAN=1 \
    TRIVY_EXPORTER_IMAGES_SCANNERS=vuln \
    TRIVY_EXPORTER_ROOTFS_PATH=/rootfs \
    TRIVY_EXPORTER_ROOTFS_SCAN=1 \
    TRIVY_EXPORTER_ROOTFS_SCANNERS=vuln
CMD [ "/usr/local/bin/trivy-exporter-start" ]
HEALTHCHECK --interval=30s --timeout=15s --start-period=30s --retries=3 CMD curl -f http://localhost:8080/metrics || exit 1