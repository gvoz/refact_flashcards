# disable docs during gem install
echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc

# essentials
sudo apt-get -y update
sudo apt-get install -y build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libcurl4-openssl-dev libpq-dev libxml2-dev libxslt-dev htop

# Git and Node.js
sudo apt-get install -y git nodejs

# ImageMagick and Rmagick
sudo apt-get install -y imagemagick libmagickwand-dev

# Postgres
sudo apt-get install -y postgresql postgresql-contrib

# nginx
sudo apt-get install -y nginx

# Redis
sudo apt-get install -y redis-server

# setup rbenv and ruby-build
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install ruby 2.3.3 and bundler
export RBENV_ROOT="${HOME}/.rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
export PATH="${RBENV_ROOT}/shims:${PATH}"
rbenv install 2.3.3
rbenv global 2.3.3
bundle config build.nokogiri "--use-system-libraries --with-xml2-include=/usr/local/opt/libxml2/include/libxml2"
gem install bundler
rbenv rehash

# cleanup
sudo apt-get clean

cd /vagrant
bundle install
rbenv rehash
sudo -u postgres psql -c "CREATE USER admin WITH PASSWORD 'password';"
sudo -u postgres psql -c "ALTER USER admin WITH SUPERUSER;"
rake db:create
rake db:migrate
rake db:seed

bundle exec rails server -b 0.0.0.0
