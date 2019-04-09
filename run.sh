#!/usr/bin/env bash
/etc/init.d/iiq_db start && \
/etc/init.d/insightiq start 2>&1 && \
echo "Startup Successful. Wait up to 5 minutes for services."
/usr/bin/tail -f /var/log/insightiq.log
