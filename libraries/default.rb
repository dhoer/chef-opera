def opera_version
  case node['platform']
  when 'windows'
    opera_windows_version
  when 'mac_os_x'
    program = node['opera']['track'] == 'stable' ? 'Opera' : 'Opera-beta'
    opera_linux_version("\"/Applications/Opera.app/Contents/MacOS/#{program}\" --version")
  else
    program = node['opera']['track'] == 'stable' ? 'opera' : 'opera-beta'
    opera_linux_version("#{program} --version")
  end
end

private

def opera_linux_version(command)
  cmd = Mixlib::ShellOut.new(command)
  cmd.run_command
  cmd.error!
  cmd.stdout.strip
end

def opera_windows_version
  program = node['opera']['track'] == 'stable' ? 'Opera' : 'Opera beta'
  xml = ::IO.read("C:\\Program Files (x86)\\#{program}\\installation_status.xml")
  xml.match(%r{name="DisplayVersion" type="REG_SZ">(.*)<\/value>})[1]
end
