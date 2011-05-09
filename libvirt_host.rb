class Chef
  class Knife
    class LibvirtHostList < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt host list (options)"
      
      def run
      end
    end

    class LibvirtHostShow < Knife
      deps do
        require 'chef/knife/bootstrap'
        require 'libvirt'
        Chef::Knife::Bootstrap.load_deps
      end
      
      def to_mb(kb)
        (kb/1024.0).round(2)
      end
      
      banner "knife libvirt host show HOST (options)"
      
      def run
        @name_args.each do |host|
          puts "Host: #{host}"
          uri = "qemu+tls://#{host}/system?pkipath=#{Chef::Config[:knife][:libvirt_tls_path]}/#{host}"
          connection = Libvirt::open(uri)
          info = connection.node_get_info
          puts "URI: #{connection.uri}"
          puts "Encrypted connection: #{connection.encrypted?}"
          puts "Secure connection: #{connection.secure?}"
          puts "Hypervisor: #{connection.type}"
          puts "Hypervisor Version: #{connection.version}"
          puts "Libvirt Version: #{connection.libversion}"
          puts "Architecture: #{info.model}"
          puts "Total Memory: #{to_mb(info.memory)} MB"
          puts "CPUs: #{info.cpus}"
          puts "Speed: #{info.mhz}"
          puts "Nodes: #{info.nodes}"
          puts "Sockets: #{info.sockets}"
          puts "Cores: #{info.cores}"
          puts "Threads: #{info.threads}"
        end
      end
    end
  end
end
