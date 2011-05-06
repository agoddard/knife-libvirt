require "chef/knife"
require "libvirt"


class Chef
  class Knife
    class LibvirtStoragePoolList < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt storage pool list (options)"
      
      option :host,
        :short => "-h HOST",
        :long => "--host HOST",
        :description => "The Libvirt host",
        :proc => Proc.new { |h| Chef::Config[:knife][:host] = h },
        :default => "qemu+tls://vmh02.core.cli.mbl.edu/system?pkipath=/usr/local/etc/pki/vmh02.core.cli.mbl.edu"

      def run
        connection = Libvirt::open(config[:host])
        puts connection.list_storage_pools
      end
    end
    
    class LibvirtStoragePoolShow < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt storage pool show POOL (options)"
      
      option :host,
        :short => "-h HOST",
        :long => "--host HOST",
        :description => "The Libvirt host",
        :proc => Proc.new { |h| Chef::Config[:knife][:host] = h },
        :default => "qemu+tls://vmh02.core.cli.mbl.edu/system?pkipath=/usr/local/etc/pki/vmh02.core.cli.mbl.edu"

      def run
        connection = Libvirt::open(config[:host])
        @name_args.each do |pool_name|
          pool = connection.lookup_storage_pool_by_name(pool_name)
          puts "Name: #{pool.name}"
          puts "UUID: #{pool.uuid}"
          puts "---------------"
          puts "Volumes: #{pool.num_of_volumes}"
          puts "Autostart: #{pool.autostart?}"
          puts "Persistent: #{pool.persistent?}"
          puts "Capacity: #{(pool.info.capacity/1073741824.0).round(2)} GB"
          puts "Allocated: #{(pool.info.allocation/1073741824.0).round(2)} GB"
          puts "Available: #{(pool.info.available/1073741824.0).round(2)} GB"
          puts "======================="
          puts
        end
      end
    end
    
    class LibvirtStorageVolumeList < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt storage volume list (options)"
      
      option :host,
        :short => "-h HOST",
        :long => "--host HOST",
        :description => "The Libvirt host",
        :proc => Proc.new { |h| Chef::Config[:knife][:host] = h },
        :default => "qemu+tls://vmh02.core.cli.mbl.edu/system?pkipath=/usr/local/etc/pki/vmh02.core.cli.mbl.edu"
      
      
      def run
        connection = Libvirt::open(config[:host])
        connection.list_storage_pools.each do |pool_name|
          puts "#{pool_name}:"
          puts "-----------------------"
          storage_pool = connection.lookup_storage_pool_by_name(pool_name)
          storage_pool.list_volumes.each do |volume|
            vol = storage_pool.lookup_volume_by_name(volume)
            puts "#{volume}\t#{(vol.info.allocation/1024.0/1024.0).round(2)} MB/#{vol.info.capacity/1024.0/1024.0} MB"
          end
          puts "======================="
        end
        # puts connection.list_vol
      end
    end
  end
end