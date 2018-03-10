#nginx config of 3 virtual hosts/server blocks that will listen to the following ports: 8081, 8082, 8083. 
#nginx loadbalancer config on port 8080 (if port 8080 is already in use, kill relevant process). 
#The load balancer to redirect requests to ports 8081, 8082, 8083 - round-robin approach - equal weight

# NGINX initial config and setup of 3 servers :
apt-get update
apt-get upgrade
apt-get install nginx
apt-get install elinks
systemctl start nginx
systemctl enable nginx 
systemctl status nginx  

# create directories for the three server blocks 
cd /var/www
mkdir -p /var/www/server1.com/html /var/www/server2.com/html /var/www/server3.com/html
#set up html sites
vi server1.com/html/index.html
vi server2.com/html/index.html
vi server3.com/html/index.html

# index html content
<html>
    <head>
        <title>Welcome to server1/server2/server3</title> 
    </head>
    <body>
        <h1>Hello from port 8081/8082/8083 </h1>
    </body>
</html>

#set up ports 
 vi /etc/nginx/sites-available/server1.com
vi /etc/nginx/sites-available/server2.com
vi /etc/nginx/sites-available/server3.com

server {
        listen 8081; #or ports 8082 or 8083
        listen [::]:8081; #or ports 8082 or 8083

        root /var/www/server1.com/html;  #or paths to  server2/server3
        index index.html index.htm;
        server_name server1.com www.server1.com; #or url to server 2 or server 3

        location / {
                try_files $uri $uri/ =404;
        }
}
#Enable server blocks by creating symbolic links from these files to the sites-enabled directory, which Nginx reads from during startup.

ln -s /etc/nginx/sites-available/server1.com /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/server2.com /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/server3.com /etc/nginx/sites-enabled/
#config test
nginx -t 
#restart
systemctl restart nginx
#test servers  
elinks http://www.server1.com:8081
elinks http://www.server2.com:8082
elinks http://www.server3.com:8083


# load balancing set up  
#########################################
 
vi /etc/nginx/sites-available/default
http {
    upstream backend {
    server server1.com:8081;
    server server2.com:8082;
    server server3.com:8083;
    }
    server {
        location / {
            proxy_pass http://backend;
        }
    }
}
