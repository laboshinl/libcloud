action :append do
    if new_resource.line.kind_of?(String)
       lines = [new_resource.line]
    else 
       lines = new_resource.line
    end 
    ruby_block "add lines" do
        block do
            lines.each do |line|
                ::File.open(new_resource.file, "a+") do |f|
                    if !(f.read =~ /#{Regexp.escape(line)}/) then 
                        f.write("\n" + line)
                    end
                end
            end
        end
    end
end
