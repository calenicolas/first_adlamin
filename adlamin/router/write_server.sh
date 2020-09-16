echo "server {

    server_name $2

    add_header X-Frame-Options" 'SAMEORIGIN' ";

    listen 8080;
    access_log /var/log/nginx/access.log compression;

    location / {
        proxy_pass http://$3:8080;
        rewrite /(.*) " '/$1' " break;
        proxy_http_version 1.1;
        proxy_set_header Upgrade" ' $http_upgrade;
        proxy_set_header Connection ' "'upgrade'" ';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}' > /etc/nginx/servers/$1.conf
