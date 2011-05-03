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
            
      banner "knife libvirt server create (options)"
      
      option :name,
        :short => "-n NAME",
        :long => "--name NAME",
        :description => "The host name of the new server"
        
      option :domain,
        :short => "-d DOMAIN",
        :long => "--domain DOMAIN",
        :description => "Domain name of the new server"
      
      
      option :memory,
        :short => "-m MEM",
        :long => "--mem MEM",
        :description => "The amount of RAM to allocate to the new server in MB",
        :default => 128
      
      option :volume_size,
        :short => "-v SIZE"
        :long => "--volume-size SIZE",
        :description => "The size of the volume in GB"

      
    end
  end
end