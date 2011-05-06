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
require "chef/knife"

class Chef
  class Knife
    class LibvirtServerCreate < Knife

      deps do
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end
            
      banner "knife libvirt server create OPTIONS"
      
      option :flavor,
        :short => "-f FLAVOR",
        :long => "--flavor FLAVOR",
        :description => "The flavor of server (small, medium, etc)",
        :proc => Proc.new { |f| Chef::Config[:knife][:flavor] = f },
        :default => "small"
        
      option :image,
        :short => "-i IMAGE",
        :long => "--image IMAGE",
        :description => "The base image for the server",
        :proc => Proc.new { |i| Chef::Config[:knife][:image] = i }
      
      option :hostname,
        :short => "-n HOSTNAME",
        :long => "--name HOSTNAME",
        :description => "The host name of the new server"
        
      option :domain,
        :short => "-d DOMAIN",
        :long => "--domain DOMAIN",
        :description => "Domain name of the new server"
        
      option :distro,
        :short => "-b BOOTSTRAP",
        :long => "--bootstrap BOOTSTRAP_FILENAME",
        :description => "Bootstrap a distro using a template",
        :proc => Proc.new { |b| Chef::Config[:knife][:distro] = b },
        :default => "ubuntu10.04-gems"
        
      option :tls_cert_directory,
        :short => "-t PATH",
        :long => "--tls-path PATH",
        :description => "The path to your libvirt TLS keys",
        :proc => Proc.new { |t| Chef::Config[:knife][:tls_cert_directory] = t}
      
      # NEW CONVENTION!!!
      # /path/to/tls/files/hostname
      
      def run
        puts config[:distro]
      end
      
    end
  end
end