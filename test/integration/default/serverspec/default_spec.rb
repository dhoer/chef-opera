require 'serverspec'

# Required by serverspec
set :backend, :exec

describe 'opera::default' do
  case os[:family]
  when 'darwin'
    describe command('/Applications/opera.app/Contents/MacOS/Google\ opera --version') do
      its(:stdout) { should match(/^[\d|.]*$/) }
      its(:exit_status) { should eq 0 }
    end
  else
    describe command('opera --version') do
      its(:stdout) { should match(/^[\d|.]*$/) }
      its(:exit_status) { should eq 0 }
    end
  end
end
