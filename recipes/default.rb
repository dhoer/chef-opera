track = node['opera']['track']
base_uri = "#{node['opera']['url']}/#{track}"

case node['platform']
when 'windows'
  setup_exe = "#{Chef::Config[:file_cache_path]}/Opera_NI_#{track}.exe"

  remote_file setup_exe do
    source "#{base_uri}/windows"
    action :nothing
  end.run_action(:create)

  execute "#{setup_exe} /silent /launchopera=0 /import-browser-data=0 /setdefaultbrowser=0" do
    action :nothing
  end.run_action(:run)
when 'mac_os_x'
  setup_exe = "#{Chef::Config[:file_cache_path]}/Opera_NI_#{track}.zip"

  remote_file setup_exe do
    source "#{base_uri}/mac"
    action :nothing
  end.run_action(:create)

  execute "unzip -o #{setup_exe}" do
    cwd Chef::Config[:file_cache_path]
    action :nothing
  end.run_action(:run)

  execute "\"#{Chef::Config[:file_cache_path]}/Opera Installer.app/Contents/MacOS/Opera Installer\" -silent" do
    action :nothing
  end.run_action(:run)
when 'ubuntu'
  apt_repository 'opera' do
    uri node['opera']['apt_uri']
    distribution 'stable'
    components %w(non-free)
    key node['opera']['apt_key']
    action :nothing
  end.run_action(:add)

  package "opera-#{track}" do
    action :nothing
  end.run_action(:install)
else
  log('Opera cannot be installed on this platform using this cookbook!') { 'level :warn' }
end
