package "apt"
package "build-essential"

#
remote_file "#{Chef::Config[:file_cache_path]}/plast-1.0.tar.gz" do
  source "http://www.irisa.fr/symbiose/projects/plast/plast-1.0.tar.gz"
  action :create_if_missing
end

#
execute "plast source compile and install" do
  command <<-CODE
set -e
(cd #{Chef::Config[:file_cache_path]}/ && tar zxvf plast-1.0.tar.gz)
(chown root:root #{Chef::Config[:file_cache_path]}/plast-1.0)
(cd #{Chef::Config[:file_cache_path]}/plast-1.0 && sed -i '52c\\\t$(CC) -o plastall $(OBJ)/main.o $(OBJFILES) $(LDFLAGS)' Makefile)
(cd #{Chef::Config[:file_cache_path]}/plast-1.0 && make)
(cd #{Chef::Config[:file_cache_path]}/plast-1.0 && cp plastall /usr/bin )
CODE
  action :run
end


# $(CC) $(LDFLAGS) -o plastall $(OBJ)/main.o $(OBJFILES)

