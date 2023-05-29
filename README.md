# trivy-exporter

## Installation

### Deploy with `docker compose`

* Create a `docker-compose.yml` file with following content:
  ```yml
  version: '2.4'
  
  services:
    trivy-exporter:
      image: firebrake/trivy-exporter
      cap_drop:
        - all
      cap_add:
        - chown
        - dac_override
        - kill
        - setgid
        - setuid
      cpus: 0.5
      mem_limit: 1G
      mem_reservation: 64m
      memswap_limit: 1G
      ports:
        - 8080:8080
      restart: unless-stopped
      volumes:
        - /:/rootfs:ro
        - /var/run/docker.sock:/var/run/docker.sock:ro
  ```
* Start it with: `docker compose up -d`

## License

![AGPL-3.0-only](https://www.gnu.org/graphics/agplv3-155x51.png)

trivy-exporter is licensed under the terms of the AGPL-3.0-only [license](LICENSE).

```txt
trivy-exporter, an exporter for Trivy providing Prometheus metrics.
Copyright (C) 2023 Jérémy WALTHER <jeremy.walther@firebrake.fr> & FIREBRAKE SAS.
Documentation and source code: <https://github.com/firebrake/docker-trivy-exporter>.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```