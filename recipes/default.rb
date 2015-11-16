#
# Cookbook Name:: backup
# Recipe:: default
#
# Copyright 2015, Simone Dall Angelo
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

if node['backup']['enabled']

  raise "Missing node['backup']['user']" if !node['backup']['user'] || node['backup']['user'].empty?

  include_recipe 'cron'

  gem_package 'backup' do
    action :install
    gem_binary '/usr/local/bin/gem'
  end

  directory "/home/#{node['backup']['user']}/Backup" do
    action :create
    owner node['backup']['user']
    group node['backup']['user']
    mode '755'
  end

  # Place config file (all commented)
  template "/home/#{node['backup']['user']}/Backup/config.rb" do
    action :create
    owner node['backup']['user']
    group node['backup']['user']
    mode '0644'
    source 'config.rb.erb'
  end

  directory "/home/#{node['backup']['user']}/Backup/models" do
    action :create
    owner node['backup']['user']
    group node['backup']['user']
    mode '755'
  end

  # Place model file (logic is here)
  template "/home/#{node['backup']['user']}/Backup/models/db_backup.rb" do
    action :create
    owner node['backup']['user']
    group node['backup']['user']
    mode '0644'
    source 'db_backup.rb.erb'
  end

  # Setup cron job
  cron_d 'daily-db-backup' do
    minute 0
    hour 5
    command "/bin/bash -l -c '/usr/local/bin/backup perform -t db_backup'"
    user node['backup']['user']
    action :create
  end

  # Restart
  service 'crond' do
    action :restart
  end

end
