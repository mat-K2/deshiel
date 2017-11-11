require 'capify-ec2'

capify_ec2 = CapifyEc2.new
role :web, *capify_ec2.get_instances_by_role("vpc-db").map(&:contact_point)
role :app, *capify_ec2.get_instances_by_role("vpc-db").map(&:contact_point)
role :db,  *capify_ec2.get_instances_by_role("vpc-db").map(&:contact_point)

@roles.each do |name, role|
  role.servers.each do |server|
    logger.info server.to_s, name
  end
end

set :rails_env, "production"
