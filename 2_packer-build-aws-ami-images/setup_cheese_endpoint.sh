#!/bin/sh
#sudo wget https://github.com/nginxinc/nginx-asg-sync/releases/download/v0.4-1/nginx-asg-sync-0.4-1.amzn2.x86_64.rpm
#sudo yum install nginx-asg-sync-0.4-1.amzn2.x86_64.rpm -y
#sudo rm nginx-asg-sync-0.4-1.amzn2.x86_64.rpm

cat > /tmp/cheese.conf <<EOF
server {
    root /usr/share/nginx/html;

    default_type  text/json;
    listen       8088 ;
    server_name  apibackend;

#    location = /jwtauth/ {
#      root   /usr/share/nginx/html;
#      index  index.html index.htm;
#    }
#
#    location = /apikey/ {
#      #root   /var/www/html;
#      index  index.html index.htm;
#    }



   location = /beemster {
        return 200 '{  "name": "Beemster",  "country": "Holland",  "region": "North",  "notes": {    "texture": "hard",    "flavour": "smooth/creamy"  } }';
    }
    location = /cheddar {
        return 200 '{  "name": "Cheddar",  "country": "England",  "region": "Somerset",  "notes": {    "texture": "firm",    "flavour": "mature"  } }';
    }
    location = /emmental {
        return 200 '{  "name": "Emmental",  "country": "Switzerland",  "region": "Canton Bern",  "notes": {    "texture": "soft",    "flavour": "savoury/mild"  } }';
    }
    location = /gouda {
        return 200 '{  "name": "Gouda",  "country": "Holland",  "region": "South",  "notes": {    "texture": "soft",    "flavour": "soapy"  } }';
    }
    location = /wensleydale {
        return 200 '{  "name": "Wensleydale",  "country": "England",  "region": "North Yorkshire",  "notes": {    "texture": "crumbly/moist",    "flavour": "honey/acidic"  } }';
    }


}
EOF

sudo mv /tmp/cheese.conf /etc/nginx/conf.d/cheese.conf
sudo nginx -s reload

