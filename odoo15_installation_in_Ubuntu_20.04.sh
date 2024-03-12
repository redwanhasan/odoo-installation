#Step 1: Log in to the Ubuntu server via SSH
ssh username@IP_Address -p Port_number

#Step 2: Update your Server
sudo apt-get update
sudo apt-get upgrade

#Step 3: Secure your server.
sudo apt-get install openssh-server fail2ban


#Step 5: Install the necessary Odoo Python packages:
#Install pip3:
sudo apt-get install -y python3-pip

#Install Packages and libraries:
sudo apt-get install python-dev python3-dev libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev libpq-dev libjpeg8-dev liblcms2-dev libblas-dev libatlas-base-dev

#Install Web web dependencies:
sudo apt-get install -y npm
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install -g less less-plugin-clean-css
sudo apt-get install -y node-less

#Step: 6: Configure Postgresql
sudo apt-get install postgresql

sudo su - postgres -c "createuser -s [username]"

#Step 7: Get Odoo 16 community from git
sudo apt-get install git

mkdir -p /home/[username]/workspace/odoo/v15
cd ~/workspace/odoo

git clone https://www.github.com/odoo/odoo --depth 1 --branch 15.0 --single-branch ./v15/

sudo pip3 install -r v15/requirements.txt

sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.bionic_amd64.deb
sudo dpkg -i wkhtmltox_0.12.5-1.bionic_amd64.deb
##if packages are note installed then run [sudo apt --fix-broken install]
sudo apt install -f

mkdir v15/odoo-custom-addons

## creating config file
sudo nano /etc/odoo15.conf

[options]
   ; This is the password that allows database operations:
   admin_passwd = [odoo master pass]
   db_host = False
   db_port = False
   db_user = [username]
   db_password = False
   addons_path = /home/[username]/workspace/odoo/v15/addons, /home/[username]/workspace/odoo/v15/odoo-custom-addons
   logfile = /var/log/odoo/odoo15.log
   

## creating service
sudo nano /etc/systemd/system/odoo15.service

[Unit]
   Description=Odoo15
   Documentation=http://www.odoo.com
   [Service]
   # Ubuntu/Debian convention:
   Type=simple
   User=[username]
   ExecStart=/home/[username]/workspace/odoo/v15/odoo-bin -c /etc/odoo15.conf
   StandardOutput=journal+console
   [Install]
   WantedBy=default.target

## configure system service 
sudo systemctl daemon-reload
sudo systemctl start odoo15.service
sudo systemctl status odoo15.service
sudo systemctl enable odoo15.service


## visit your odoo installation
http://[ip address]:8069

##Check Odoo Logs
sudo tail -f /var/log/odoo/odoo.log

## for debugger log use this
sudo journalctl -u odoo15
