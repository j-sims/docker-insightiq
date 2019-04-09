#!/usr/bin/env bash
IPV6="${WITH_IPV6_DISABLED:-FALSE}"
if [[ "$IPV6" == TRUE ]] && [[ -x /disable_ipv6.sh ]]; then
	/disable_ipv6.sh && rm /disable_ipv6.sh
fi
/etc/init.d/iiq_db start && \
/etc/init.d/insightiq start 2>&1 && \
echo "Startup Successful. Wait up to 5 minutes for services."
/usr/bin/tail -f /var/log/insightiq.log
