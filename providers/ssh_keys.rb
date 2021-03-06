action :add do
  dir = Mixlib::ShellOut.new("echo ~#{new_resource.user}")
  dir.run_command
  dir.error!
  homedir = dir.stdout[0..-2]
    directory "#{homedir}/.ssh" do
        path "#{homedir}/.ssh"
        owner new_resource.user
        group new_resource.user
        mode "0700"
        action :create
    end
    ssh_keypair = data_bag_item(new_resource.data_bag, new_resource.keypair)
    libcloud_file_append "#{homedir}/.ssh/authorized_keys" do
        line ssh_keypair["public_key"]
    end
end

action :create do
  dir = Mixlib::ShellOut.new("echo ~#{new_resource.user}")
  dir.run_command
  dir.error!
  homedir = dir.stdout[0..-2]
    directory "#{homedir}/.ssh" do
        path "#{homedir}/.ssh"
        owner new_resource.user
        group new_resource.user
        mode "0700"
        action :create
    end
    ssh_keypair = data_bag_item(new_resource.data_bag, new_resource.keypair)
    file "#{homedir}/.ssh/" + new_resource.key_name do
        action :create_if_missing
        owner new_resource.user
        group new_resource.user
        mode "0600"
        content ssh_keypair["private_key"]
    end
    file "#{homedir}/.ssh/" + new_resource.key_name + ".pub" do
        action :create_if_missing
        owner new_resource.user
        group new_resource.user
        mode "0600"
        content ssh_keypair["public_key"]
    end
end
