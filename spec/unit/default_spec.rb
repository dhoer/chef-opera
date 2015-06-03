require 'spec_helper'

describe 'opera_test::default' do
  context 'exe' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2').converge(described_recipe) }

    it 'installs opera' do
      expect(chef_run).to install_windows_package('Opera 29.0.1795.60')
    end
  end

  context 'dmg' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.10').converge(described_recipe) }

    it 'installs opera' do
      expect(chef_run).to install_dmg_package('Opera')
    end
  end

  context 'apt' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

    it 'adds repo' do
      expect(chef_run).to add_apt_repository('opera')
    end

    it 'installs opera' do
      expect(chef_run).to install_apt_package('opera-stable')
    end
  end
end
