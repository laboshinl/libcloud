action :download do
#    gem_package "net-scp"
    chef_gem "net-scp"
    ruby_block "execute command over ssh" do
        block do
            require 'net/scp'
            Net::SSH.start( new_resource.server, new_resource.user, 
                            :port => new_resource.port,
                            :password => new_resource.password) do |ssh|
                ssh.scp.download! new_resource.remote_path, new_resource.local_path
            end
        end
    end
end

action :upload do
    #gem_package "net-scp"
    chef_gem "net-scp"
    ruby_block "execute command over ssh" do
        block do
            require 'net/scp'
            Net::SSH.start( new_resource.server, new_resource.user, 
                            :port => new_resource.port,
                            :password => new_resource.password) do |ssh|
                ssh.scp.upload! new_resource.local_path, new_resource.remote_path
            end
        end
    end
end

