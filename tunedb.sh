#!/bin/bash
cat /var/cache/insightiq/pgsql/data/postgresql.conf | sed 's/^shared_buffers\ \=\ 2GB/shared_buffers\ \=\ 6GB/g' | sed 's/^work_mem\ \=\ 10MB/work_mem\ \=\ 32MB/g' > /tmp/postgresql.conf && mv /var/cache/insightiq/pgsql/data/postgresql.conf /var/cache/insightiq/pgsql/data/postgresql.conf.orig && cp /tmp/postgresql.conf /var/cache/insightiq/pgsql/data/postgresql.conf
