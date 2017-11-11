require 'bundler/capistrano'
require "capify-ec2/capistrano"

set :application, "deshiel"

##
# multistage settings
#
class ResponseException < Exception; end
set :stages, %w(production admin)
set :default_stage, "production"
require 'capistrano/ext/multistage'


set :repository,  "git@github.com:matk2/deshiel.git"
set :scm, :git
set :branch, "master"
set :user, "ec2-user"
set :use_sudo, false
set :deploy_to, "/home/#{user}/webapps/#{application}"
set :ssh_options, {
  keys: [ENV['SSH_KEYS']]
}

after "deploy:update", roles: [:app, :db] do
  run "/bin/cp #{shared_path}/config/database.yml #{release_path}/config/"
  run "/bin/cp #{shared_path}/config/unicorn.rb #{release_path}/config/"
  run "/bin/cp #{shared_path}/config/ec2.yml #{release_path}/config/"
end
