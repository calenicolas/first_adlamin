
writeServer $1 $2 $3

writeServer() {
  PROJECT_NAME=$1
  URL=$2
  ROUTER_IP=$3

  echo "server {

      server_name $URL

      add_header X-Frame-Options" 'SAMEORIGIN' ";

      listen 8080;
      access_log /var/log/nginx/access.log compression;

      location / {
          proxy_pass http://$ROUTER_IP:8080;
          rewrite /(.*) " '/$1' " break;
          proxy_http_version 1.1;
          proxy_set_header Upgrade" ' $http_upgrade;
          proxy_set_header Connection ' "'upgrade'" ';
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
      }
  }' > /etc/nginx/servers/$PROJECT_NAME.conf
}