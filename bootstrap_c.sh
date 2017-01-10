echo "gem: --no-document" > ~/.gemrc

sudo yum -y install epel*
sudo yum -y update
sudo yum -y install build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libcurl4-openssl-dev libpq-dev libxml2-dev libxslt-dev htop
sudo yum -y install openssl-devel readline-devel zlib-devel

# Git and Node.js
sudo yum -y install git nodejs

# ImageMagick and Rmagick
sudo yum -y install imagemagick libmagickwand-dev

# Postgres
sudo yum -y installpostgresql postgresql-contrib

# nginx
sudo yum -y install nginx

# Redis
sudo yum -y install redis-server

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
gem install bundler
bundle config --global silence_root_warning 1
rbenv rehash

cd /vagrant
bundle install
rbenv rehash
sudo -u postgres psql -c "CREATE USER admin WITH PASSWORD 'password';"
sudo -u postgres psql -c "ALTER USER admin WITH SUPERUSER;"
rake db:create
rake db:migrate
rake db:seed

bundle exec rails server -b 0.0.0.0
