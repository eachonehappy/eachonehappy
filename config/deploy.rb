# config valid only for current version of Capistrano
lock "3.7.1"


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
# config valid only for current version of Capistrano


set :repo_url, 'git@github.com:eachonehappy/eachonehappy.git'
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :user, 'deployer'
set :application, 'eachonehappy'
set :rails_env, 'production'
server '148.72.244.107', user: "#{fetch(:user)}", roles: %w{app db web}, primary: true
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :pty, true

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/puma.rb')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :config_example_suffix, '.example'
set :config_files, %w{config/database.yml config/secrets.yml}
set :puma_conf, "#{shared_path}/config/puma.rb"

namespace :deploy do
  before 'check:linked_files', 'config:push'
  before 'check:linked_files', 'puma:config'
  before 'check:linked_files', 'puma:nginx_config'
  before 'deploy:migrate', 'deploy:db:create'
  after 'puma:smart_restart', 'nginx:restart'
end