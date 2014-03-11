ruby '2.0.0'
source "http://rubygems.org"
source "http://gems.hashicorp.com"

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

group :development do
    gem "vagrant", :path => '/Users/jtopper/git/vagrant'
    gem "rake"
end

group :plugins do
    gem "vagrant-vmware-fusion"
    gem "vagrant-multiprovider-snap", path: "."
end
