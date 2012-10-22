#rake db:reset --trace RAILS_ENV="production"
#rake db:migrate --trace RAILS_ENV="production"
rake db:drop --trace
rake db:create --trace
rake db:migrate --trace
rake db:test:load
