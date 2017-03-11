# config valid only for current version of Capistrano
lock "3.8.0"

set :repo_url, 'git@github.com:PavelBezpalov/alexa-fop.git'
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :user, 'rails'
set :application, 'alexa-fop'

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :pty, false

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/puma.rb')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle',
                                               'public/system', 'public/uploads')

set :config_example_suffix, '.example'
set :config_files, %w(config/database.yml config/secrets.yml)
set :puma_conf, "#{shared_path}/config/puma.rb"
set :puma_preload_app, true
set :puma_init_active_record, true
set :puma_threads, [0, 8]

set :nginx_config_name, "#{fetch(:application)}_#{fetch(:stage)}"
set :nginx_use_ssl, true
