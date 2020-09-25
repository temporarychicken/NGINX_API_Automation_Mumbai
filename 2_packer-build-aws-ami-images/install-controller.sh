# Please insert your username and password for NoIP.com in the line below, and also any domain name you have reserved there that you would like to use (mandatory). Also change any controller login parameters you wish to (optional)


export NOIP_HOSTNAME=workshop0001.nginxdemo.net
export NOIP_SUBNAME=controller
export NOIP_USERNAME=davidluke
export NOIP_PASSWORD=xxxxxxx





############################################
# NO FURTHER EDITS NECESSARY BELOW THIS LINE
############################################

export CONTROLLER_FIRSTNAME=Brian
export CONTROLLER_SURNAME=Eno
export CONTROLLER_USERNAME=a.user@f5.com
export CONTROLLER_PASSWORD=Password1
export CTR_APIGW_CERT=fullchain.pem
export CTR_APIGW_KEY=controller.key

# Update the NoIP dynamic DNS record for NOIP_HOSTNAME

#export AWS_PUBLIC_IP=`dig +short myip.opendns.com @resolver1.opendns.com`
#echo AWS_PUBLIC_IP

#echo "Updating DNS record"
#curl -vv http://$NOIP_USERNAME:$NOIP_PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$NOIP_HOSTNAME&myip=$AWS_PUBLIC_IP

# Wait a bit until our domain name is resolving to the public IP of this new amazon controller machine.

#export CURRENT_RESOLVING_PUBLIC_IP=`dig +short $NOIP_SUBNAME.$NOIP_HOSTNAME`

#until [ $CURRENT_RESOLVING_PUBLIC_IP = $AWS_PUBLIC_IP ]
#do
#  export CURRENT_RESOLVING_PUBLIC_IP=`dig +short $NOIP_SUBNAME.$NOIP_HOSTNAME`
#  echo DNS lookup for $NOIP_HOSTNAME reveals $CURRENT_RESOLVING_PUBLIC_IP but our AWS public IP is $AWS_PUBLIC_IP
#  echo 'Waiting another ten seconds, then trying the DNS query again....';
#  sleep 10
#done

# Fetch a certificate from Let's Encrypt for the Controller using acme.sh ............

# We will use acme.sh and socat. The tool socat allows acme to stand up a temporary server on port 80 to pass the acme check, and prove we own our domain name.

# Install acme.sh to fetch the cert for us

#echo "Installing acme.sh for cert generation"

#curl https://get.acme.sh | sh


# Fetch the certificate and store it in place - NOTE this will issue an ownership challenge to port 80 on the Controller

#sudo -H ~/.acme.sh/acme.sh --issue --standalone --force -d $NOIP_SUBNAME.$NOIP_HOSTNAME -w ~/controller_cert.crt --dns dns_aws
#mkdir ~/certs
#sudo cp /root/.acme.sh/$NOIP_SUBNAME.$NOIP_HOSTNAME/fullchain.cer $CTR_APIGW_CERT
#sudo cp /root/.acme.sh/$NOIP_SUBNAME.$NOIP_HOSTNAME/$NOIP_SUBNAME.$NOIP_HOSTNAME.key $CTR_APIGW_KEY




# Install NGINX Controller

#echo 'export PATH=$PATH:/snap/bin/' >>.bashrc


until controller-installer/install.sh -n -m 127.0.0.1 -x 12321 -b false -g false -j $CONTROLLER_USERNAME -e $CONTROLLER_USERNAME -p $CONTROLLER_PASSWORD -f $NOIP_SUBNAME.$NOIP_HOSTNAME -t $CONTROLLER_FIRSTNAME -u $CONTROLLER_SURNAME -w -y --tsdb-volume-type local -a NGINX ; do sleep 10; done

# Apply the license file to Controller

ansible-playbook nginx_controller_deploy_license.yaml



#Questions:

#This script requires docker ce to be installed, would you like to intall it?
#Provide time series DB volume type [local, nfs, aws]:
#Read the terms, quit them with 'q' and agree them with 'y' and enter
#SMTP host
#SMTP port
#SMTP auth
#Provide a do-not-reply email address:
#Provide the FQDN for your Controller:
#Provide the organization name:
#Provide the admin's first name:
#Provide the admin's last name:
#Provide the admin's email address:
#Provide the admin's password. Passwords must be 6 to 64 characters, and must include letters and digits:
#Repeat password:
#Would you like to generate a self-signed certificate now? [y/n]?

#   CTR_APIGW_CERT                      SSL/TLS cert file path, cannot be used together with --self-signed-cert
#   CTR_APIGW_KEY                       SSL/TLS key file path, cannot be used together with --self-signed-cert
#   CTR_DB_HOST                         Database host
#   CTR_DB_PORT                         Database port
#   CTR_DB_USER                         Database user
#   CTR_DB_PASS                         Database password
#   CTR_DB_ENABLE_SSL                   Require a SSL connection to the database
#   CTR_DB_CA                           Path to the CA certificate file to use for SSL connection to the database
#   CTR_DB_CLIENT_CERT                  Path to the client certificate file to use for SSL connection to the database
#   CTR_DB_CLIENT_KEY                   Path to the key file to use for SSL connection to the database
#   CTR_SMTP_HOST                       SMTP host
#   CTR_SMTP_PORT                       SMTP port
#   CTR_SMTP_AUTH                       Specify if SMTP server requires username and password (true or false)
#   CTR_SMTP_TLS                        Specify if SMTP should use TLS (true or false)
#   CTR_SMTP_FROM                       Specify the email to show in the 'FROM' field
#   CTR_SMTP_USER                       SMTP user (required when CTR_SMTP_AUTH is true)
#   CTR_SMTP_PASS                       SMTP password (required when CTR_SMTP_AUTH is true)
#   CTR_EMAIL                           Admin user email
#   CTR_PASSWORD                        Admin user password
#   CTR_FIRSTNAME                       Admin user first name
#   CTR_LASTNAME                        Admin user last name
#   CTR_ORGNAME                         Organization name
#   CTR_FQDN                            FQDN (domain) for NGINX Controller web frontend, for example, controller.example.com
#   CTR_TSDB_VOL_TYPE                   Time series database volume type (local, nfs, aws)
#   CTR_TSDB_AWS_ID                     AWS Volume ID (required when CTR_TSDB_VOL_TYPE is 'aws')
#   CTR_TSDB_NFS_HOST                   Time series database NFS path (required when CTR_TSDB_VOL_TYPE is 'nfs')
#   CTR_TSDB_NFS_PATH                   Time series database NFS host (required when CTR_TSDB_VOL_TYPE is 'nfs')


#export   CTR_SMTP_HOST=127.0.0.1
#export   CTR_SMTP_PORT=12321
#export   CTR_SMTP_AUTH=false
#export   CTR_SMTP_TLS=false
#export   CTR_SMTP_FROM=d.luke@f5.com
#export   CTR_EMAIL=d.luke@f5.com
#export   CTR_PASSWORD='ToiletRoll130!&$'
#export   CTR_FIRSTNAME=David
#export   CTR_LASTNAME=Luke
#export   CTR_ORGNAME=NGINX
#export   CTR_FQDN=nginxcontroller.hopto.org
#export   CTR_TSDB_VOL_TYPE=local

#./controller-installer/install.sh -n -w -c -y





#Machine Spec:

#T2.extra-large with 16GB (default 8)


#Command Log (manual):

#    1  wget -q https://sll-nginx-workshop-demo-eu-west-1.s3-eu-west-1.amazonaws.com/app_centric_automation/controller-installer-3.3.0.tar.gz
#    2  tar -xvf controller-installer-3.3.0.tar.gz
#    3  sudo -H apt update -y
#    4  sudo -H apt install jq -y
#    5  ./controller-installer/install.sh -n


#    printf "%-38s %s\n" "   -d | --db-host" "Database host"
#    printf "%-38s %s\n" "   -k | --db-port" "Database port"
#    printf "%-38s %s\n" "   -r | --db-user" "Database user"
#    printf "%-38s %s\n" "   -s | --db-pass" "Database password"
#    printf "%-38s %s\n" "   --db-enable-ssl" "Require a SSL connection to the database"
#    printf "%-38s %s\n" "   --db-ca" "Path to the CA certificate file to use for SSL connection to the database"
#    printf "%-38s %s\n" "   --db-client-cert" "Path to the client certificate file to use for SSL connection to the database"
#    printf "%-38s %s\n" "   --db-client-key" "Path to the key file to use for SSL connection to the database"
#    printf "%-38s %s\n" "   -m | --smtp-host" "SMTP host"
#    printf "%-38s %s\n" "   -x | --smtp-port" "SMTP port"
#    printf "%-38s %s\n" "   -b | --smtp-authentication" "Specify if SMTP server requires username and password (true or false)"
#    printf "%-38s %s\n" "   -g | --smtp-use-tls" "Specify if SMTP should use TLS (true or false)"
#    printf "%-38s %s\n" "   -j | --noreply-address" "Specify the email to show in the 'FROM' field"
#    printf "%-38s %s\n" "   -e | --admin-email" "Admin user email"
#    printf "%-38s %s\n" "   -p | --admin-password" "Admin user password"
#    printf "%-38s %s\n" "   -f | --fqdn" "FQDN (domain) for NGINX Controller web frontend, for example, controller.example.com"
#    printf "%-38s %s\n" "   --tsdb-volume-type" "Time series database volume type (local, nfs, aws)"
#    printf "%-38s %s\n" "   -a | --organization-name" "Organization name"
#    printf "%-38s %s\n" "   -t | --admin-firstname" "Admin user first name"
#    printf "%-38s %s\n" "   -u | --admin-lastname" "Admin user last name"
#    printf "%-38s %s\n" "   -l | --smtp-user" "SMTP user (required when smtp-authentication is enabled)"
#    printf "%-38s %s\n" "   -q | --smtp-password" "SMTP password (required when smtp-authentication is enabled)"
#    printf "%-38s %s\n" "   --tsdb-aws-volume-id" "AWS Volume ID (required when tsdb-volume-type is 'aws')"
#    printf "%-38s %s\n" "   --tsdb-nfs-host" "Time series database NFS path (required when tsdb-volume-type is 'nfs')"
#    printf "%-38s %s\n" "   --tsdb-nfs-path" "Time series database NFS host (required when tsdb-volume-type is 'nfs')"
#    echo "Optional: These arguments are optional specifications"
#    printf "%-38s %s\n" "   --apigw-cert" "SSL/TLS cert file path, cannot be used together with --self-signed-cert"
#    printf "%-38s %s\n" "   --apigw-key" "SSL/TLS key file path, cannot be used together with --self-signed-cert"
#    printf "%-38s %s\n" "   -c | --self-signed-cert" "Specify if the installation process should create a self signed cert for SSL/TLS"
#    printf "%-38s %s\n" "   -w | --auto-install-docker" "Specify if Docker CE should be installed if missing without confirmation"
#    printf "%-38s %s\n" "   -i | --passive" "Install as a cold standby, not running database migrations and not starting any services"
#    printf "%-38s %s\n" "   -y | --accept-license" "Automatically accept EULA"

#./controller-installer/install.sh -n --smtp-host=127.0.0.1 --smtp-port=12321 --smtp-authentication=false --smtp-use-tls=false --noreply-address=d.luke@f5.com --admin-email=d.luke@f5.com --admin-password='ToiletRoll130!&$' --fqdn=nginxcontroller.hopto.org --admin-firstname=David --admin-lastname=Luke --self-signed-cert --auto-install-docker --accept-license

#./controller-installer/install.sh -n -m 127.0.0.1 -x 12321 -b false -g false -j d.luke@f5.com -e d.luke@f5.com -p 'ToiletRoll130!&$' -f nginxcontroller.hopto.org -t David -u Luke -c -w -y --tsdb-volume-type local -a NGINX
