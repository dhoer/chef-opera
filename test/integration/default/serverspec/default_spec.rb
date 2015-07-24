require 'serverspec'

# Required by serverspec
if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, family: 'windows'
end

describe 'opera::default' do
  case os[:family]
  when 'windows'
    describe file('/Applications/opera.app/Contents/MacOS/Google\ opera --version') do
      its(:stdout) { should match(/^[\d|.]*$/) }
    end
  when 'darwin'
    describe command('/Applications/opera.app/Contents/MacOS/Google\ opera --version') do
      its(:stdout) { should match(/^[\d|.]*$/) }
    end
  else
    describe command('opera --version') do
      its(:stdout) { should match(/^[\d|.]*$/) }
    end
  end
end
