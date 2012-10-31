#!/bin/bash
rm -rf public/assets
rake assets:precompile --trace RAILS_ENV=production
DATE=`date +%Y%m%d%H%M`
tar jcvf ../release/ozjapanese_com_au_$DATE.tar.bz2\
 app/controllers\
 app/helpers\
 app/mailers\
 app/models\
 app/views\
 script\
 config/locales\
 config/routes.rb\
 config/application.rb\
 config/boot.rb\
 config/environment.rb\
 config/initializers\
 config/environments/production.rb\
 db/migrate\
 lib\
 public/*html\
 public/assets\
 public/favicon.ico\
 public/robots.txt
rm -rf public/assets
