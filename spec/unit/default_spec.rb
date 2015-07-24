require 'spec_helper'

describe 'opera_test::default' do
  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'windows', version: '2008R2', file_cache_path: 'C:/chef/cache').converge(described_recipe)
    end

    it 'downloads opera' do
      expect(chef_run).to create_remote_file('C:/chef/cache/Opera_NI_stable.exe')
    end

    it 'installs opera' do
      expect(chef_run).to run_execute(
        'C:/chef/cache/Opera_NI_stable.exe /silent /launchopera=0 /import-browser-data=0 /setdefaultbrowser=0')
    end
  end

  context 'macosx' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(
        platform: 'mac_os_x', version: '10.10', file_cache_path: '/var/chef/cache').converge(described_recipe)
    end

    it 'downloads opera' do
      expect(chef_run).to create_remote_file('/var/chef/cache/Opera_NI_stable.zip')
    end
  end

  context 'ubuntu' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

    it 'adds repo' do
      expect(chef_run).to add_apt_repository('opera')
    end

    it 'installs opera' do
      expect(chef_run).to install_package('opera-stable')
    end
  end

  context 'other' do
    let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

    it 'logs not supported warning' do
      expect(chef_run).to write_log('Opera cannot be installed on this platform using this cookbook!')
    end
  end
end
