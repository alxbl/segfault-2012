require 'bundler/capistrano'

set :application, "segfault.me"

set :repository,  "git@segfault:site.git"
set :branch, "master"
set :scm, :git
set :git_enable_submodules, true
set :deploy_via, :remote_cache

set :ssh_options, {:forward_agent => true}
set :default_shell, "zsh -l" # FIXME: Get rid of RVM in production. Seriously.

# Shared Articles
set :linked_dirs, fetch(:linked_dirs) + %w{public/articles}

server "segfault", :app, :web, :db, :primary => true

namespace :deploy do
  after "deploy:update_code", "rvm:trust_rvmrc"
  after "deploy:update_code", "extra:symlink_db"

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

namespace :rvm do
  desc 'Trust rvmrc'
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end

namespace :extra do
  desc 'Symlink databses.yml to the application.'
  task :symlink_db, :role => :app do
    run "ln -nfs #{shared_path}/system/database.yml #{release_path}/config/database.yml"
  end
end

namespace :content do
  desc 'Indexes new articles in production or updates an existing article with -s slug=article-slug'
  task :update, :role => :app do
    run (variables.include? :slug) ? "cd #{deploy_to}/current && #{rake} \"crawl:index[#{slug}]\" RAILS_ENV=production"
                       : "cd #{deploy_to}/current && #{rake} crawl:new RAILS_ENV=production"
  end
end
# TODO: set :use_sudo, false
