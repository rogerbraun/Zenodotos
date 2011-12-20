require "bundler/capistrano"
require "capistrano/ext/multistage"
#require "rvm/capistrano"                  # Load RVM's capistrano plugin.

set :application, "Zenodotos"
set :repository,  "git://github.com/rogerbraun/Zenodotos.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "rokuhara.japanologie.kultur.uni-tuebingen.de"                          # Your HTTP server, Apache/etc
role :app, "rokuhara.japanologie.kultur.uni-tuebingen.de"                          # This may be the same as your `Web` server
role :db,  "rokuhara.japanologie.kultur.uni-tuebingen.de", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_via, :remote_cache
set :user, "edv"
set :use_sudo, false

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :db_setup do
  task :create_shared, :roles => :app do
    run "mkdir -p #{deploy_to}/#{shared_dir}/db/"
    run "chmod 1777 #{deploy_to}/#{shared_dir}/db/"
    run "mkdir -p #{deploy_to}/#{shared_dir}/pdf/"
    run "chmod 1777 #{deploy_to}/#{shared_dir}/pdf/"
  end

  task :link_shared do
    run "rm -rf #{release_path}/db/sqlite"
    run "ln -nfs #{shared_path}/db #{release_path}/db/sqlite"
    run "rm -rf #{release_path}/public/pdf"
    run "ln -nfs #{shared_path}/pdf #{release_path}/public/pdf"
  end
end

after "deploy:update_code", "db_setup:link_shared"
after "deploy:setup", "db_setup:create_shared"
