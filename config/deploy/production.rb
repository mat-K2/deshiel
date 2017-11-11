require 'capify-ec2'

capify_ec2 = CapifyEc2.new
role :web, *capify_ec2.get_instances_by_role("web").map(&:contact_point)
role :app, *capify_ec2.get_instances_by_role("app").map(&:contact_point)
role :db,  *capify_ec2.get_instances_by_role("vpc-db").map(&:contact_point), :primary => true

@roles.each do |name, role|
  role.servers.each do |server|
    logger.info server.to_s, name
  end
end

set :rails_env, "production"

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
