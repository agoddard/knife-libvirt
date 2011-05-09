class Chef
  class Knife
    class LibvirtFlavorList < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt flavor list (options)"
      
      def run
        host = "qemu+tls://#{Chef::Config[:knife][:libvirt_host]}/system?pkipath=#{Chef::Config[:knife][:libvirt_tls_path]}/#{Chef::Config[:knife][:libvirt_host]}"
        connection = Libvirt::open(host)
      end
    end

    class LibvirtFlavorShow < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt flavor show FLAVOR (options)"
      
      def run
        host = "qemu+tls://#{Chef::Config[:knife][:libvirt_host]}/system?pkipath=#{Chef::Config[:knife][:libvirt_tls_path]}/#{Chef::Config[:knife][:libvirt_host]}"
        connection = Libvirt::open(host)
      end
    end

    class LibvirtFlavorEdit < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt flavor edit FLAVOR (options)"
      
      def run
        host = "qemu+tls://#{Chef::Config[:knife][:libvirt_host]}/system?pkipath=#{Chef::Config[:knife][:libvirt_tls_path]}/#{Chef::Config[:knife][:libvirt_host]}"
        connection = Libvirt::open(host)
      end
    end
    
    class LibvirtFlavorFromFile < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt flavor from file FLAVOR FILE (options)"

      def run
        flavor, file = @name_args
        # modify file here -- add the attributes to the JSON that need to be added
        dbag = Chef::DataBagItem.new
        dbag.data_bag('libvirt_flavors')
        dbag.raw_data = item # item is json
        dbag.save
        # modify json file into what chef expects with all the defaults we want
        # call the chef methods that save the data bag.
      end
    end
  end
end