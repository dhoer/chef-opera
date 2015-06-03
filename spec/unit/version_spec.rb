require 'spec_helper'

describe 'opera_test::version' do
  context 'windows install' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do
        allow_any_instance_of(Chef::Recipe).to receive(:opera_version).and_return('29.0.1795.60')
      end.converge(described_recipe)
    end

    it 'returns opera version' do
      expect(chef_run).to write_log('29.0.1795.60')
    end
  end

  context 'mac install' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'mac_os_x', version: '10.10') do
        allow_any_instance_of(Chef::Recipe).to receive(:opera_version).and_return('29.0.1795.60')
      end.converge(described_recipe)
    end

    it 'returns opera version' do
      expect(chef_run).to write_log('29.0.1795.60')
    end
  end

  context 'linux install' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do
        allow_any_instance_of(Chef::Recipe).to receive(:opera_version).and_return('29.0.1795.60')
      end.converge(described_recipe)
    end

    it 'returns opera version' do
      expect(chef_run).to write_log('29.0.1795.60')
    end
  end
end
