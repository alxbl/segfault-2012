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

namespace :rvm do
  desc 'Trust .rvmrc from the repository.'
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end

after "deploy:update_code", "rvm:trust_rvmrc"

# TODO: set :use_sudo, false
# TODO: local_cache using gitolite
