#! /bin/sh
# git clone git@repo.moh.gov.et:gebreyohannes/swoss.git
sudo apt-get install git-core curl
# Adding Node.js repository
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
# Adding Yarn repository
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo add-apt-repository ppa:chris-lea/redis-server
# Refresh our packages list with the new repositories
sudo apt-get update
# Install our dependencies for compiiling Ruby along with Node.js and Yarn
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates redis-server redis-tools nodejs yarn
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
rbenv install 2.7.2
rbenv global 2.7.2
ruby -v
# ruby 2.7.2
cd swoss
gem install bundler
bundle install
sudo apt install libpq-dev
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
sudo ls /etc/nginx/conf.d/mod-http-passenger.conf
sudo apt-get install postgresql postgresql-contrib libpq-dev
current_user=$(whoami)	
echo "Congratulations! Please continue setting up server manually as described below
      sudo nano /etc/nginx/conf.d/mod-http-passenger.conf
      --- change the passenger_ruby line to match the following ---
      passenger_ruby /home/$current_user/.rbenv/shims/ruby;
      sudo rm /etc/nginx/sites-enabled/default
      --- Creating a PostgreSQL Database ---
      sudo su - postgres
      createuser --superuser --createdb --createrole --replication --pwprompt swoss
      --- set password to be: postgres
      createdb -O swoss swmoss_prod
      -- add the following line in ~/.profile
      export DATABASE_URL="postgres://swoss:postgres@127.0.0.1/swmoss_prod"
      RAILS_ENV=production bundle exec rake db:migrate
      RAILS_ENV=production bundle exec rake db:seed
    "
echo "--- Create virtual server ---"
echo "sudo nano /etc/nginx/sites-enabled/swmoss
    --- copy the following lines and paste ---
    server {
        listen 80;
        listen [::]:80;
        
        server_name swmoss.com;
        root /home/$current_user/swoss/public;
        
        passenger_enabled on;
        passenger_app_env production;
        
        location /cable { 
            passenger_app_group_name myapp_websocket;
            passenger_force_max_concurrent_requests_per_process 0;
        }
       
        # Allow uploads up to 100MB in size
        client_max_body_size 100m;
        \n
        location ~ ^/(assets|packs) {
            expires max;
            gzip_static on;
        }
    }
"
echo 'sudo service nginx start'

