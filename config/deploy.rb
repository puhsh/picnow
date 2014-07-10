require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :domain, ''
set :deploy_to, '/var/www/'
set :repository, 'git@github.com:puhsh/picnow.git'
set :branch, 'master'
set :shared_paths, ['config/database.yml', 'log']
set :hipchat_auth_token, ''
set :hipchat_rooms, ['Fun Town']
set :hipchat_from, 'Puhshbot'

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[echo "-----> Be sure to edit 'shared/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
    end
  end
end
