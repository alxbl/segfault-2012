set :application, "segfault.me"
set :repository,  "git@github.com:alxbl/segfault.me.git"
set :scm, :git

server "segfault", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
