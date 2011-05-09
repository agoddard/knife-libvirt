#
# Author:: Anthony Goddard (<anthony@anthonygoddard.com>)
# Author:: Chuck Ha (<ggnextmap@gmail.com>)
# Copyright:: Copyright (c) 2011 Woods Hole Marine Biological Laboratory.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class Chef
  class Knife
    class LibvirtServerList < Knife
      deps do
        require 'chef/knife/bootstrap'
        require 'libvirt'
        Chef::Knife::Bootstrap.load_deps
      end
            
      banner "knife libvirt server list (options)"
      
      option :flavor,
        :short => "-f FLAVOR",
        :long => "--flavor FLAVOR",
        :description => "The flavor of server (small, medium, etc)",
        :proc => Proc.new { |f| Chef::Config[:knife][:flavor] = f },
        :default => "small"
        
      option :system,
        :short => "-s SYSTEM ",
        :long => "--system SYSTEM",
        :description => "A system filename",
        :proc => Proc.new { |i| Chef::Config[:knife][:system] = i }
      
      option :hostname,
        :short => "-n HOSTNAME",
        :long => "--name HOSTNAME",
        :description => "The host name of the new server"
        
      option :domain,
        :short => "-d DOMAIN",
        :long => "--domain DOMAIN",
        :description => "Domain name of the new server"
        
      option :bootstrap,
        :short => "-b BOOTSTRAP",
        :long => "--bootstrap BOOTSTRAP_FILENAME",
        :description => "Bootstrap a distro using a template",
        :proc => Proc.new { |b| Chef::Config[:knife][:distro] = b },
        :default => "ubuntu10.04-gems"
        
      option :libvirt_tls_path,
        :short => "-t PATH",
        :long => "--tls-path PATH",
        :description => "The path to your libvirt TLS keys",
        :proc => Proc.new { |t| Chef::Config[:knife][:libvirt_tls_path] = t}
        
        
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


      def get_domain_info(domain)
        states = ["No State","Active","Blocked","Paused","Shutting Down","Inactive","Crashed"]
        # TODO reformat
        puts "Name: #{domain.name}"
        puts "ID: #{domain.uuid}"
        puts "---------------"
        puts "Memory: #{to_mb(domain.info.memory)} MB"
        puts "Maximum Memory: #{to_mb(domain.max_memory)} MB"
        puts "CPUs: #{domain.info.nr_virt_cpu}"
        puts "State: #{states[(domain.info.state)]}"
        puts "======================="
        puts
      end

      
      def run
        host = "qemu+tls://#{Chef::Config[:knife][:libvirt_host]}/system?pkipath=#{Chef::Config[:knife][:libvirt_tls_path]}/#{Chef::Config[:knife][:libvirt_host]}"
        connection = Libvirt::open(host)
        puts "Host: #{Chef::Config[:knife][:libvirt_host]}"
        puts "Active: #{connection.num_of_domains}"
        puts "Inactive: #{connection.num_of_defined_domains}"
        puts "---------------"
        connection.list_domains.each do |domain_id|
          domain = connection.lookup_domain_by_id(domain_id)
          get_domain_info(domain)
        end
        connection.list_defined_domains.each do |domain_name|
          domain = connection.lookup_domain_by_name(domain_name)
          get_domain_info(domain)
        end
      end
    end

    class LibvirtServerCreate < Knife

      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
            
      banner "knife libvirt server create (options)"
      
      option :flavor,
        :short => "-f FLAVOR",
        :long => "--flavor FLAVOR",
        :description => "The flavor of server (small, medium, etc)",
        :proc => Proc.new { |f| Chef::Config[:knife][:flavor] = f },
        :default => "small"
        
      option :system,
        :short => "-s SYSTEM ",
        :long => "--system SYSTEM",
        :description => "A system filename",
        :proc => Proc.new { |i| Chef::Config[:knife][:system] = i }
      
      option :hostname,
        :short => "-n HOSTNAME",
        :long => "--name HOSTNAME",
        :description => "The host name of the new server"
        
      option :domain,
        :short => "-d DOMAIN",
        :long => "--domain DOMAIN",
        :description => "Domain name of the new server"
        
      option :bootstrap,
        :short => "-b BOOTSTRAP",
        :long => "--bootstrap BOOTSTRAP_FILENAME",
        :description => "Bootstrap a distro using a template",
        :proc => Proc.new { |b| Chef::Config[:knife][:distro] = b },
        :default => "ubuntu10.04-gems"
        
      option :libvirt_tls_path,
        :short => "-t PATH",
        :long => "--tls-path PATH",
        :description => "The path to your libvirt TLS keys",
        :proc => Proc.new { |t| Chef::Config[:knife][:libvirt_tls_path] = t}

      
      def run
        puts "nothing to see here"
      end
      
    end
  end
end
