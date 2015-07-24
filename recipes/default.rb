require 'open-uri'

version = node['opera']['browser']['version']
base_uri = "#{node['opera']['browser']['url']}/#{version}"

case node['platform']
when 'windows'
  setup_exe = "#{Chef::Config[:file_cache_path]}/Opera_NI_#{version}.exe"

  remote_file setup_exe do
    source "#{base_uri}/windows"
    action :nothing
  end.run_action(:create)

  execute "#{setup_exe} /silent /launchopera=0 /import-browser-data=0 /setdefaultbrowser=0" do
    action :nothing
  end.run_action(:run)
when 'mac_os_x'
  dmg_package 'Opera' do
    dmg_name "Opera_#{version}_Setup"
    accept_eula true
    source "#{base_uri}/mac/Opera_#{version}_Setup.dmg"
    action :nothing
  end.run_action(:install)
when 'ubuntu'
  apt_repository 'opera' do
    uri node['opera']['browser']['apt_uri']
    distribution 'stable'
    components %w(non-free)
    key node['opera']['browser']['apt_key']
    action :nothing

  end.run_action(:add)

  package "opera-#{node['opera']['browser']['version']}" do
    action :nothing
  end.run_action(:install)
else
  Chef::Log.warn('Opera cannot be installed on this platform using this cookbook.')
end
