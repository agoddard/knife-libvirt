class Chef
  class Knife
    class LibvirtFlavorList < Knife

      deps do
        require 'chef/knife/bootstrap'
        require 'libvirt'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt flavor list (options)"
      
      def run
        host = "qemu+tls://#{Chef::Config[:knife][:libvirt_host]}/system?pkipath=#{Chef::Config[:knife][:libvirt_tls_path]}/#{Chef::Config[:knife][:libvirt_host]}"
        connection = Libvirt::open(host)
      end
    
    end
  end
end