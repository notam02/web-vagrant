sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y vim curl python-software-properties
# sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

# Install php7 and apache
sudo apt-get install -y php #apache2 libapache2-mod-php7 php7-curl php7-gd php7-mcrypt mysql-server-5.5 php7-mysql git-core php7-xdebug php7.2-cli
sudo apt-get install -y apache2 apache2-doc apache2-npm-prefork apache2-utils libexpat1 ssl-cert

# Install mySQL
sudo apt-get install -y mysql-server mysql-client libmysqlclient-dev

# Create wordpress database
mysql -uroot -proot -e "CREATE DATABASE wordpress;"

# zip
sudo apt-get install -y zip

cat << EOF | sudo tee -a /etc/php7/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

sudo a2enmod rewrite

sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php7/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php7/apache2/php.ini
sudo sed -i "s/disable_functions = .*/disable_functions = /" /etc/php7/cli/php.ini

sudo service apache2 restart

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Get wordpress
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
sudo mv wordpress/* /var/www/html/

# Install phpmyadmin
# sudo apt-get -y install phpmyadmin

debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password root"
debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect none"
apt-get -y install mysql-server phpmyadmin #>> /vagrant/vm_build.log 2>&1

# Nodejs
sudo apt-get -y install curl
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs

# Gulp
npm install -g gulp-cli

# Add default apache user to vagrant group
# usermod -a -G vagrant www-data

# Symbolic link for html dir 
ln -sf /var/www/html html
ln -sf /var/www/html/wp-content/themes themes

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt -y install yarn
