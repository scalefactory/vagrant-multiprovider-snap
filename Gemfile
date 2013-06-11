source "http://rubygems.org"
source "http://gems.hashicorp.com"

unless File.exist?( File.join( File.dirname(__FILE__), 'license-vagrant-vmware-fusion.lic' ) )
    $stderr.puts "You need a vmware fusion license to work on this code"
    $stderr.puts "Try copying .vagrant.d/license-vagrant-vmware-fusion.lic to this folder"
    exit -1
end

# This probably needs to change if you're not on a Mac, or
# if you've installed the vagrant distribution somewhere else
ENV["VAGRANT_INSTALLER_EMBEDDED_DIR"] = '/Applications/Vagrant/embedded/'

# Specify your gem's dependencies in vagrant-snap.gemspec
gemspec

gem "vagrant", :git => "git://github.com/mitchellh/vagrant.git"
gem "vagrant-vmware-fusion"
