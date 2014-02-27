ruby '2.0.0'
source "http://rubygems.org"
source "http://gems.hashicorp.com"

unless File.exist?( File.join( File.dirname(__FILE__), 'license-vagrant-vmware-fusion.lic' ) )
    $stderr.puts "You need a vmware fusion license to work on this code"
    $stderr.puts "Try copying .vagrant.d/license-vagrant-vmware-fusion.lic to this folder"
    exit -1
end

embedded_locations = %w{/Applications/Vagrant/embedded /opt/vagrant/embedded}

embedded_locations.each do |p|
    ENV["VAGRANT_INSTALLER_EMBEDDED_DIR"] = p if File.directory?(p)
end

unless ENV.has_key?('VAGRANT_INSTALLER_EMBEDDED_DIR')
    $stderr.puts "Couldn't find a packaged install of vagrant, and we need this"
    $stderr.puts "in order to make use of the RubyEncoder libraries."
    $stderr.puts "I looked in:"
    embedded_locations.each do |p|
        $stderr.puts "  #{p}"
    end
end

# Specify your gem's dependencies in vagrant-snap.gemspec
gemspec

gem "vagrant", :git => "git://github.com/mitchellh/vagrant.git"
gem "vagrant-vmware-fusion"
