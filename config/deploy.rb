require 'bundler/capistrano'
require "capify-ec2/capistrano"

set :application, "deshiel"
set :rails_env, "production"

capify_ec2 = CapifyEc2.new
role :web, *capify_ec2.get_instances_by_role("web").map(&:contact_point)
role :app, *capify_ec2.get_instances_by_role("app").map(&:contact_point)
role :db,  *capify_ec2.get_instances_by_role("vpc-db").map(&:contact_point), :primary => true

@roles.each do |name, role|
  role.servers.each do |server|
    logger.info server.to_s, name
  end
end

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

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    begin
      run "bash -l -c 'cd #{current_path} && bundle exec rake unicorn:restart'"
    rescue => error
      puts error.message
      exit 1
    end
  end
end
