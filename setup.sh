#!/bin/bash
cat > /etc/nginx/conf.d/axinavigation.conf << 'NGINX'
server {
    listen 80;
    server_name axinavigation.com www.axinavigation.com;
    root /var/www/axinavigation;
    index index.html;
    location / {
        try_files $uri $uri/ =404;
    }
}
NGINX
nginx -t && systemctl enable nginx && systemctl restart nginx && echo "NGINX_OK"
firewall-cmd --permanent --add-service=http 2>/dev/null || true
firewall-cmd --permanent --add-service=https 2>/dev/null || true
firewall-cmd --reload 2>/dev/null || true
echo "FIREWALL_OK"
certbot --nginx -d axinavigation.com -d www.axinavigation.com --non-interactive --agree-tos --email contact@axinavigation.com --redirect && echo "SSL_OK"
