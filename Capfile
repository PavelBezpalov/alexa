require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/nginx'
require 'capistrano/puma'
require 'capistrano/puma/nginx'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails/migrations'
require 'capistrano/upload-config'
require 'sshkit/sudo'
require 'capistrano/scm/git'
install_plugin Capistrano::SCM::Git
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
