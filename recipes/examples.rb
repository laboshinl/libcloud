# Manage ssh-keys
# required data bag with folowing structure:
# $ knife data bag show ssh_keypairs openstack
#       id : openstack
#       private_key: -----BEGIN RSA PRIVATE KEY----- ... -----END RSA PRIVATE KEY-----
#       public_key: ssh-rsa ... user@host
# :create puts files in /home/user/.ssh/ folder
# :add adds public key to authorized_keys
libcloud_ssh_keys "openstack" do
    data_bag "ssh_keypairs"    
    key_name "my_key" # default is id_rsa 
    action [:create, :add] 
end

# Execute command on remote host
libcloud_ssh_command "ls" do
    server "195.208.117.177"
    password "vBh!3dFv" 
    # port 22
    # user root
    # command ["w", "uname", "echo 'Hello world!'"]
end

# Download file from remote host
libcloud_file_scp "/tmp/file.txt" do
    server "195.208.117.177" # required!
    password "vBh!3dFv" # NULL
    # port 22
    # user root
    # local_path "/tmp/file.txt"
    remote_path "/tmp/file.txt" # required!
    action :download # default
    # action :upload
end 

# Upload file to remote host
libcloud_file_scp "/tmp/file.txt" do
    server "195.208.117.177" # required!
    password "vBh!3dFv" # NULL
    # port 22
    # user root
    # local_path "/tmp/file.txt"
    remote_path "/tmp/file.txt" # required!
    #action :download # default
    action :upload
end 

# loop until port unavailable with delay and timeout
libcloud_api_wait "localhost" do
    port "22"
    # timeout 300
    # delay 2     
end
