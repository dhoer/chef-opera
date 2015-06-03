require 'open-uri'

version = node['opera']['browser']['version']
path = version == 'beta' ? 'opera-beta' : 'opera/desktop'
base_uri = "#{node['opera']['browser']['url']}/#{path}"

if %w(stable beta).include?(version)
  out = open(base_uri).read
  version = out.scan(%r{<a href=.*>([\d|.]*)/</a>}).last.join('')
end

case node['platform']
when 'windows'
  windows_package "Opera #{version}" do
    source "#{base_uri}/#{version}/win/Opera_#{version}_Setup.exe"
    installer_type :installshield
    action :nothing
  end.run_action(:install)
when 'mac_os_x'
  dmg_package 'Opera' do
    dmg_name "Opera_#{version}_Setup"
    accept_eula true
    source "#{base_uri}/#{version}/mac/Opera_#{version}_Setup.dmg"
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

  track = node['opera']['browser']['version'] == 'beta' ? 'beta' : 'stable'
  package "opera-#{track}" do
    action :nothing
  end.run_action(:install)
else
  Chef::Log.warn('Opera cannot be installed on this platform using this cookbook.')
end
