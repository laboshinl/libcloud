action :run do
    gem_package "net-ssh"
    chef_gem "net-ssh"
    if new_resource.command.kind_of?(String)
        commands = [new_resource.command]
    else
        commands = new_resource.command
    end
    ruby_block "execute command over ssh" do
        block do
            require 'net/ssh'
            Net::SSH.start( new_resource.server, new_resource.user, 
                            :port => new_resource.port,
                            :password => new_resource.password) do |ssh|
                commands.each do |command|
                    stdout = ""
                    ssh.exec!(command) do |channel, stream, data|
                        stdout << data if stream == :stdout
                    end
                    puts stdout
                end
            end
        end
    end
end
