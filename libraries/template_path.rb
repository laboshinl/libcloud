#
# Author:: Adam Jacob (<adam@opscode.com>)
# Author:: Seth Chisamore (<schisamo@opscode.com>)
# Author:: Tyler Cloke (<tyler@opscode.com>)
# Copyright:: Copyright (c) 2008, 2011 Opscode, Inc.
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

require 'chef/resource/file'
require 'chef/provider/template'
require 'chef/mixin/securable'

class Chef
  class Resource
    class Template < Chef::Resource::File
      include Chef::Mixin::Securable

      provides :template

      attr_reader :inline_helper_blocks
      attr_reader :inline_helper_modules

      def initialize(name, run_context=nil)
        super
        @resource_name = :template
        @action = "create"
        @source = "#{name[1..-1]}.erb"
        @cookbook = nil
        @local = false
        @variables = Hash.new
        @inline_helper_blocks = {}
        @inline_helper_modules = []
        @helper_modules = []
      end
    end
  end
end

