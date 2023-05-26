# Copyright (C) 2023 Jérémy WALTHER <jeremy.walther@firebrake.fr> & FIREBRAKE SAS.
# trivy-exporter is licensed under the terms of the AGPL-3.0-only license.
# See <https://github.com/firebrake/docker-trivy-exporter> or README.md file for details.
# min   hour    day     month   weekday command
${TRIVY_EXPORTER_COMPUTE_CRON_MINUTES}       ${TRIVY_EXPORTER_COMPUTE_CRON_HOURS}       *       *       *       /usr/bin/flock -n /var/run/trivy-exporter-compute.lock /usr/local/bin/trivy-exporter-compute
