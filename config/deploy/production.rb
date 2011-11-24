set :application, "cook"
set :repository,  "git@github.com:hechien/cook.git"
set :domain, "192.168.173.109"
set :deploy_to, "/home/apps/cook"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true        # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env,  "production"
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false
set :user, "apps"
set :group, "apps"

default_environment["PATH"] = "/home/apps/.rvm/gems/ruby-1.9.2-p290/bin:/home/apps/.rvm/gems/ruby-1.9.2-p290@global/bin:/home/apps/.rvm/rubies/ruby-1.9.2-p290/bin:/home/apps/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games"
after("deploy:update") do
  run "rvm 1.9.2"
end

namespace :deploy do
  desc "restart"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

desc "Create database.yml and asset packages for production"
after("deploy:update_code") do
  db_config = "#{shared_path}/config/database.yml.production"
  run "cp #{db_config} #{release_path}/config/database.yml"
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end