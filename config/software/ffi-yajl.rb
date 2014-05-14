#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
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

name "ffi-yajl"
default_version "master"
relative_path "ffi-yajl"

source :git => "git://github.com/lamont-granquist/ffi-yajl"

if platform == 'windows'
  dependency "ruby-windows"
  dependency "ruby-windows-devkit"
else
  dependency "libffi"
  dependency "ruby"
  dependency "rubygems"
end

build do
  bundle "install --without development_extras", :env => {"PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}"}
  bundle "exec rake gem", :env => {"PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}"}
  command "rm -rf pkg/*java*"
  gem ["install pkg/ffi-yajl-*.gem",
       "--no-rdoc --no-ri"].join(" "), :env => {"PATH" => "#{install_dir}/embedded/bin:#{ENV['PATH']}"}
end
