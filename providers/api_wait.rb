action :wait do
    ruby_block "wait for server" do
        block do
            require 'timeout'
            require 'socket'
            def test_api(hostname, port)
                s = TCPSocket.new(hostname, port)
                s.close
                return true
            rescue SocketError
                return false
            rescue Errno::ETIMEDOUT
                return false
            rescue Errno::EPERM
                return false
            rescue Errno::ECONNREFUSED
                return false
            rescue Errno::EHOSTUNREACH
                return false
            rescue Errno::ENETUNREACH
                return false
            end
            Timeout::timeout(new_resource.timeout) do
                until test_api(new_resource.address, new_resource.port) do
                    sleep new_resource.delay
                end
            end
        end
    end
    new_resource.updated_by_last_action(true)
end
