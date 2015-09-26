name 'opera'
maintainer 'Dennis Hoer'
maintainer_email 'dennis.hoer@gmail.com'
license 'MIT'
description 'Installs Opera browser'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

# supports 'mac_os_x'
supports 'ubuntu'
supports 'windows'

depends 'apt', '~> 2.8'

source_url 'https://github.com/dhoer/chef-opera' if respond_to?(:source_url)
issues_url 'https://github.com/dhoer/chef-opera/issues' if respond_to?(:issues_url)
