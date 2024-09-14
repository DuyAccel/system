#!/bin/sh
cd my-server &&

docker compose up -d --build &&

docker exec rerverse-proxy sh -c '
  apk add certbot-nginx
  certbot \
          --nginx -m nguyenchauhieuduy@outlook.com \
          --agree-tos \
          --no-eff-email \
          -d duy.io.vn \
          -d website.duy.io.vn \
          -d cicd.duy.io.vn
'
echo '
0 0,12 * * * docker exec reverse-proxy certbot renew >> /home/ubuntu/my-server/ssl.log
' > renew_ssl

crontab renew_ssl
