class Chef
  class Knife
    class LibvirtFlavorList < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
        require 'chef/data_bag'
        end
      
      banner "knife libvirt flavor list (options)"
      
      def run
        Chef::DataBag.load("libvirt_flavors").each do |name,uri|
          puts "  #{name}"
        end
      end
    end

    class LibvirtFlavorShow < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
        require 'chef/data_bag'
      end
      
      banner "knife libvirt flavor show FLAVOR (options)"
      
      def run
        @name_args.each do |flavor_name|
          output(format_for_display(Chef::DataBagItem.load("libvirt_flavors", flavor_name).raw_data))
          puts
        end
      end
    end

    class LibvirtFlavorEdit < Knife
      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt flavor edit FLAVOR (options)"
      
      def run
        #TODO bring the flavor into edit mode.
        "[NT]"
      end
    end
    
    class LibvirtFlavorFromFile < Knife
      deps do
        require 'chef/knife/bootstrap'
        require 'chef/knife/core/object_loader'
        Chef::Knife::Bootstrap.load_deps
      end
      
      banner "knife libvirt flavor from file FILE (options)"
      
      def loader
        @loader ||= Knife::Core::ObjectLoader.new(DataBagItem, ui)
      end
      
      def create_dbag
        begin
          rest.post_rest("data", { "name" => "libvirt_flavors" })
        rescue Net::HTTPServerException => e
          puts "Data bag #{@data_bag_name} already exists"
        end
      end

      def run
        file = @name_args.first
        item = loader.load_from("data_bags", "libvirt_flavors", file)
        dbag = Chef::DataBagItem.new
        dbag.data_bag("libvirt_flavors")
        dbag.raw_data = item # item is json
        begin
          dbag.save
        rescue
          create_dbag
          puts "Creating data bag for libvirt flavors"
          dbag.save
        end
        puts "Updated flavor '#{dbag.id}'"

        # modify json file into what chef expects with all the defaults we want
        # call the chef methods that save the data bag.
      end
    end
  end
end