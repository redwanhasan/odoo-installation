##----Odoo installation For Ubuntu 22.04----##

sudo apt update 
sudo apt upgrade

sudo apt install python3-pip wget python3-dev python3-venv python3-wheel libxml2-dev libpq-dev libjpeg8-dev liblcms2-dev libxslt1-dev zlib1g-dev libsasl2-dev libldap2-dev build-essential git libssl-dev libffi-dev libmysqlclient-dev libjpeg-dev libblas-dev libatlas-base-dev -y


sudo apt install postgresql -y
sudo su - postgres -c "createuser -s [username]"

wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_amd64.deb
sudo apt install ./libssl1.1_1.1.0g-2ubuntu4_amd64.deb

wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb

sudo chmod +x wkhtmltox_0.12.6-1.focal_amd64.deb
sudo apt install ./wkhtmltox_0.12.6-1.focal_amd64.deb

sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf


mkdir -p /home/[username]/workspace/odoo/v16
cd ~/workspace/odoo
git clone https://www.github.com/odoo/odoo --depth 1 --branch 16.0 --single-branch ./v16/

python3 -m venv odoo16-venv
source odoo16-venv/bin/activate
pip3 install wheel
pip3 install -r v16/requirements.txt
deactivate


mkdir v16/odoo-custom-addons

## creating config file
sudo nano /etc/odoo16.conf

[options]
; This is the password that allows database operations:
admin_passwd = [username]@localhost
db_host = False
db_port = False
db_user = [username]
db_password = False
addons_path = /home/[username]/workspace/odoo/v16/addons,/home/[username]/workspace/odoo/v16/odoo-custom-addons


## creating service
sudo nano /etc/systemd/system/odoo16.service

[Unit]
Description=Odoo16
Requires=postgresql.service
After=network.target postgresql.service

[Service]
Type=simple
SyslogIdentifier=odoo16
PermissionsStartOnly=true
User=[username]
Group=[username]
ExecStart=/home/[username]/workspace/odoo/odoo16-venv/bin/python3 /home/[username]/workspace/odoo/v16/odoo-bin -c /etc/odoo16.conf
StandardOutput=journal+console

[Install]
WantedBy=multi-user.target

## configure system service 
sudo systemctl daemon-reload
sudo systemctl start odoo16.service
sudo systemctl status odoo16.service
sudo systemctl enable odoo16.service

## visit your odoo installation
http://localhost:8069

## for debugger log use this
sudo journalctl -u odoo16
