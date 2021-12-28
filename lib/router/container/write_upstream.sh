echo "location /$1 {
    proxy_pass http://$2:$3;
    rewrite /$1(.*) " '/$1' " break;
    proxy_http_version 1.1;
    proxy_set_header Upgrade" ' $http_upgrade;
    proxy_set_header Connection ' "'upgrade'" ';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
}' > /etc/nginx/upstreams/$1.conf