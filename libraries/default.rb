def opera_version
  case node['platform']
  when 'windows'
    # TODO: add window version
  when 'mac_os_x'
    opera_linux_version('"/Applications/Opera.app/Contents/MacOS/Opera" --version')
  else
    opera_linux_version('opera --version')
  end
end

private

def opera_linux_version(command)
  shellout!(command).stdout
end
