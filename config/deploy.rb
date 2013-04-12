set :application, "segfault.me"
set :repository,  "git@github.com:alxbl/segfault.me.git"
set :scm, :git
set :ssh_options, {:forward_agent => true}

server "segfault", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# TODO: set :use_sudo, false
# TODO: local_cache using gitolite
