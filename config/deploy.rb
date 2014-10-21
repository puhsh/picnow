require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'

set :user, 'picnow'
set :domain, 'ec2-54-172-158-208.compute-1.amazonaws.com'
set :deploy_to, '/var/www/www.picnow.co'
set :repository, 'git@github.com:puhsh/picnow.git'
set :branch, 'master'
set :shared_paths, %w{log tmp/pids tmp/sockets config/database.yml}
set :hipchat_auth_token, ''
set :hipchat_rooms, ['Fun Town']
set :hipchat_from, 'Puhshbot'

task :environment do
  invoke 'rvm:use[2.1.2@picnow]'
end

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/pids]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/pids"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]
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
      queue 'kill -s USR2 `cat /var/www/www.picnow.co/shared/tmp/pids/unicorn.picnow.pid`'
    end

    to :restart_rpush do
      queue '"kill -s HUP `cat /var/www/www.picnow.co/sharedtmp/pids/rpush.pid`"'
    end
  end
end
