#!/bin/bash
rm -rf public/assets
rake assets:precompile --trace RAILS_ENV=production
DATE=`date +%Y%m%d%H%M`
tar jcvf ../release/ozjapanese_com_au_$DATE.tar.bz2\
 app\
 config.ru\
 doc\
 lib\
 public\
 config\
 db\
 Rakefile\
 script\
 vendor\
 public
rm -rf public/assets
