##----Odoo installation For Ubuntu 20.04 and 22.04----##

sudo apt install git python3-pip build-essential wget python3-dev python3-venv python3-wheel libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev postgresql -y

sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3.8-dev python3.8-venv python3.8-distutils python3.8-lib2to3 python3.8-gdbm python3.8-tk -y

sudo apt install wkhtmltopdf -y

pip3 install --upgrade pip
pip3 install wheel setuptools

sudo su - postgres -c "createuser -s techlead"

mkdir -p /home/techlead/workspace/odoo/v14
cd ~/workspace/odoo

git clone https://www.github.com/odoo/odoo --depth 1 --branch 14.0 ./v14/


python3.8 -m venv odoo-venv
source odoo-venv/bin/activate
python3.8 -m pip install --upgrade pip
pip3 install -r v14/requirements.txt
deactivate 


mkdir v14/odoo-custom-addons

## creating config file
sudo nano /etc/odoo14.conf

[options]
; This is the password that allows database operations:
admin_passwd = techlead@localhost
db_host = False
db_port = False
db_user = techlead
db_password = False
addons_path = /home/techlead/workspace/odoo/v14/addons,/home/techlead/workspace/odoo/v14/odoo-custom-addons
limit_memory_hard = 2684354560
limit_memory_soft = 2147483648
limit_request = 8192
limit_time_cpu = 600
limit_time_real = 1200
max_cron_threads = 1
workers = 5

## creating service
sudo nano /etc/systemd/system/odoo14.service

[Unit]
Description=Odoo14
Requires=postgresql.service
After=network.target postgresql.service

[Service]
Type=simple
SyslogIdentifier=odoo14
PermissionsStartOnly=true
User=techlead
Group=techlead
ExecStart=/home/techlead/workspace/odoo/odoo-venv/bin/python3 /home/techlead/workspace/odoo/v14/odoo-bin -c /etc/odoo14.conf
StandardOutput=journal+console

[Install]
WantedBy=multi-user.target

## configure system service 
sudo systemctl daemon-reload
sudo systemctl enable --now odoo14
sudo systemctl status odoo14

## visit your odoo installation
http://localhost:8069

## for debugger log use this
sudo journalctl -u odoo14
