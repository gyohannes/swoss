#! /bin/sh
sudo apt-get install git-core curl
# Adding Node.js repository
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
# Adding Yarn repository
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# Refresh our packages list with the new repositories
sudo apt-get update
# Install our dependencies for compiiling Ruby along with Node.js and Yarn
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev dirmngr gnupg apt-transport-https ca-certificates nodejs yarn
sudo rm -rf $HOME/.rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
rbenv install 2.7.2
rbenv global 2.7.2
sudo apt install libpq-dev
gem install bundler
bundle install
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger focal main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y nginx-extras libnginx-mod-http-passenger
if [ ! -f /etc/nginx/modules-enabled/50-mod-http-passenger.conf ]; then sudo ln -s /usr/share/nginx/modules-available/mod-http-passenger.load /etc/nginx/modules-enabled/50-mod-http-passenger.conf ; fi
sudo apt-get install -y postgresql postgresql-contrib
echo "Congratulations! Please continue setting up database and virtual server as described below
      sudo nano /etc/nginx/conf.d/mod-http-passenger.conf
      --- change the passenger_ruby line to match the following ---
      passenger_ruby $HOME/.rbenv/shims/ruby;
      sudo rm /etc/nginx/sites-enabled/default
      --- Creating a PostgreSQL Database ---
      sudo su - postgres
      createuser --superuser --createdb --createrole --replication --pwprompt swoss
      createdb -O swoss swmoss_prod
      -- Set DATABASE_URL
      Note: replace <password> with the password you set above for swoss
      export DATABASE_URL=postgresql://swoss:<password>@localhost:5432/swmoss_prod
      RAILS_ENV=production bundle exec rake db:create
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
        root $HOME/swoss/public;
        
        passenger_enabled on;
        passenger_app_env production;
        passenger_env_var DATABASE_URL $DATABASE_URL;
        
        location /cable { 
            passenger_app_group_name myapp_websocket;
            passenger_force_max_concurrent_requests_per_process 0;
        }
       
        # Allow uploads up to 100MB in size
        client_max_body_size 100m;

        location ~ ^/(assets|packs) {
            expires max;
            gzip_static on;
        }
    }
"
echo 'sudo service nginx start'

