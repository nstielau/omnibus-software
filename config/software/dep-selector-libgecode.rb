#
# Copyright:: Copyright (c) 2014 Chef Software, Inc.
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

name "dep-selector-libgecode"
default_version "1.0.0"

dependency "bundler"

# Force RHEL 5 and others to use the correct version of GCC
test = Mixlib::ShellOut.new("test -f /usr/bin/gcc44")
test.run_command

env = if test.exitstatus == 0
        { 'CC' => 'gcc44', 'CXX' => 'g++44' }
      else
        {}
      end

build do
  path_key = ENV.keys.grep(/\Apath\Z/i).first
  env[path_key] = path_with_embedded

  gem "install dep-selector-libgecode --no-rdoc --no-ri -v '#{version}'",
      env: env
end
