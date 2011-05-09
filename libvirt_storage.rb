class Chef
  class Knife
    class LibvirtStoragePoolList < Knife
      include LibvirtKnife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt storage pool list (options)"

#TODO re-enable arguments with defaults from knife.rb      
      # option :host,
      #   :short => "-h HOST",
      #   :long => "--host HOST",
      #   :description => "The Libvirt host",
      #   :proc => Proc.new { |h| Chef::Config[:knife][:libvirt_host] = h },
      #   :default => Chef::Config[:knife][:libvirt_host]
      #   # :default => "qemu+tls://#{Chef::Config[:knife][:libvirt_host]}/system?pkipath=#{Chef::Config[:knife][:libvirt_tls_path]}/#{Chef::Config[:knife][:libvirt_host]}"
      # 
      # option :libvirt_tls_path,
      #   :short => "-t PATH",
      #   :long => "--tls-path PATH",
      #   :description => "The path to your libvirt TLS keys",
      #   :proc => Proc.new { |t| Chef::Config[:knife][:libvirt_tls_path] = t},
      #   :default => Chef::Config[:knife][:libvirt_tls_path]

      def run
        connection = connect(Chef::Config[:knife][:libvirt_host], Chef::Config[:knife][:libvirt_tls_path])
        puts connection.list_storage_pools
      end
    end
        
    class LibvirtStoragePoolShow < Knife
      include LibvirtKnife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt storage pool show POOL (options)"
      
      def run
        connection = connect(Chef::Config[:knife][:libvirt_host], Chef::Config[:knife][:libvirt_tls_path])
        @name_args.each do |pool_name|
          pool = connection.lookup_storage_pool_by_name(pool_name)
          puts "Name: #{pool.name}"
          puts "UUID: #{pool.uuid}"
          puts "---------------"
          puts "Volumes: #{pool.num_of_volumes}"
          puts "Autostart: #{pool.autostart?}"
          puts "Persistent: #{pool.persistent?}"
          puts "Capacity: #{to_gb(pool.info.capacity)} GB"
          puts "Allocated: #{to_gb(pool.info.allocation)} GB"
          puts "Available: #{to_gb(pool.info.available)} GB"
          puts "======================="
          puts
        end
      end
    end
    
    class LibvirtStorageVolumeList < Knife
      include LibvirtKnife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt storage volume list (options)"
      
      def run
        connection = connect(Chef::Config[:knife][:libvirt_host], Chef::Config[:knife][:libvirt_tls_path])
        connection.list_storage_pools.each do |pool_name|
          puts "#{pool_name}:"
          puts "-----------------------"
          storage_pool = connection.lookup_storage_pool_by_name(pool_name)
          storage_pool.list_volumes.each do |volume|
            vol = storage_pool.lookup_volume_by_name(volume)
            puts "#{volume} #{to_mb(vol.info.allocation)} MB/#{to_mb(vol.info.capacity)} MB"
          end
          puts "======================="
        end
      end
      
      class LibvirtStorageVolumeShow < Knife
        include LibvirtKnife
        deps do
          require 'chef/knife/bootstrap'
          Chef::Knife::Bootstrap.load_deps
        end
    
        banner "knife libvirt storage volume show POOL VOLUME (options)"
        
    
        def run
          connection = connect(Chef::Config[:knife][:libvirt_host], Chef::Config[:knife][:libvirt_tls_path])
          @name_args.each_slice(2) do |pool_name, volume_name|
            volume = connection.lookup_storage_pool_by_name(pool_name).lookup_volume_by_name(volume_name)
            puts "Name: #{volume.name}"
            puts "Pool: #{volume.pool.name}"
            puts "---------------"
            puts "Capacity:  #{to_mb(volume.info.capacity)} MB"
            puts "Allocated: #{to_mb(volume.info.allocation)} MB"
            puts "Path: #{volume.path}"
            puts "Key:  #{volume.key}"
            puts "======================="
            puts
          end
        end
      end
    end
  end
end