require 'libvirt'

class Chef
  class Knife
    module LibvirtKnife          
      def connect(host, path)
        host = "qemu+tls://#{host}/system?pkipath=#{path}/#{host}"
        connection = Libvirt::open(host)
      end
      
      def to_gb(kb)
        (kb/1073741824.0).round(2)
      end
      
      def to_mb(kb)
        (kb/1048576.0).round(2)
      end 
    end
  end
end
