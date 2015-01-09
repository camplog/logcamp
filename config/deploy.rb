require 'bundler/capistrano'
require 'delayed/recipes'

server '50.116.63.166', :web, :app, :db, primary: true

set :application, 'logcamp'
set :user, 'deployer'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :rails_env, 'production'

set :scm, 'git'
set :repository, 'git@bitbucket.org:olimart/logcamp.git'
set :branch, 'master'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy:setup', 'init:set_permissions'
after 'deploy:setup', 'init:config_files'
after 'deploy:setup', 'init:setup_config'
after 'deploy:restart', 'deploy:restart_sidekiq'
# after 'deploy:restart', 'delayed_job:restart'

after 'deploy', 'deploy:cleanup' # keep only the last 5 releases

namespace :init do
  desc 'Set proper permissions for deployment user'
  task :set_permissions do
    sudo "mkdir -p #{shared_path}/config"
    sudo "chown -R #{user}:admin #{deploy_to}"
  end

  desc 'Create config files'
  task :config_files do
    put File.read('config/database.sample.yml'), "#{shared_path}/config/database.yml"
    put File.read('config/application.sample.yml'), "#{shared_path}/config/application.yml"

    puts "Now edit the config files in #{shared_path}."
  end

  desc 'Create server config symlinks'
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
  end
end

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :symlink_config, roles: :app do
    puts 'Run symlink'
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
  end
  after 'deploy:finalize_update', 'deploy:symlink_config'

  desc 'Make sure local git is in sync with remote.'
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before 'deploy', 'deploy:check_revision'

  desc 'Release tagging to view what is installed on server. Check out github.com/username/repo/tags'
  namespace :git do
    task :push_deploy_tag do
      user = `git config --get user.name`.chomp
      # email = `git config --get user.email`.chomp
      puts `git tag "#{release_name}-production-deploy--#{current_revision}" -m "Deployed by #{user}"`
      puts `git push origin --tags`
    end
  end

  task :restart_sidekiq, roles: :app do
    puts 'Restarting sidekiq'
    run "sudo stop sidekiq app=#{deploy_to}/current index=0 && sudo start sidekiq app=#{deploy_to}/current index=0"
  end
end


###### DB TASKS #######
namespace :db do
  desc 'Migrate database'
  task :migrate, roles: :app do
    run "cd #{current_path}; bundle exec rake RAILS_ENV=production -f #{current_path}/Rakefile db:migrate --trace"
  end

  desc 'Seed database'
  task :seed, roles: :app do
    run "cd #{current_path}; bundle exec rake RAILS_ENV=production -f #{current_path}/Rakefile db:seed --trace"
  end

  desc 'Drop & Migrate database'
  task :reset, roles: :app do
    run "cd #{current_path}; bundle exec rake RAILS_ENV=production -f #{current_path}/Rakefile db:drop db:migrate --trace"
  end
end