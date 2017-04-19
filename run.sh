/etc/init.d/iiq_db start 2>&1 && \
sleep 30 && \
/etc/init.d/insightiq start 2>&1 && \
echo "Startup Successful. Wait up to 5 minutes for services."
/usr/bin/tail -f /var/log/insightiq_stdio.log 
