ruby '2.0.0'
source "http://rubygems.org"
source "http://gems.hashicorp.com"

require 'fileutils'

embedded_locations = %w{/Applications/Vagrant/embedded /opt/vagrant/embedded C:\\HashiCorp\Vagrant\embedded}

embedded_locations.each do |p|
    if File.directory?(p)
        ENV["VAGRANT_INSTALLER_EMBEDDED_DIR"] = p
    end
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

    # We depend on Vagrant for development, but we don't add it as a
    # gem dependency because we expect to be installed within the
    # Vagrant environment itself using `vagrant plugin`.

    gem "vagrant", :git => "git://github.com/mitchellh/vagrant.git"
    gem "rake"

    if ENV['VAGRANT_DEFAULT_PROVIDER'] == 'vmware_fusion'

        # Jump through annoying hoops so we can use this plugin in the
        # bundler environment.

        fusion_path = Gem::Specification.find_by_name('vagrant-vmware-fusion').gem_dir

        unless File.symlink?( File.join( fusion_path, 'rgloader' ) )
            $stderr.puts "Linking local 'rgloader' file to embedded installer"
            FileUtils.ln_s(
                File.join( ENV["VAGRANT_INSTALLER_EMBEDDED_DIR"], 'rgloader' ),
                File.join( fusion_path, 'rgloader' )
            )
        end

        unless File.symlink?( File.join( fusion_path, 'license-vagrant-vmware-fusion.lic' ) )
            $stderr.puts "Linking your license file for vmware plugin"
            FileUtils.ln_s(
                File.join( ENV["HOME"], '.vagrant.d', 'license-vagrant-vmware-fusion.lic' ),
                File.join( fusion_path, 'license-vagrant-vmware-fusion.lic' )
            )
        end

    end

end


group :plugins do
    gem "vagrant-multiprovider-snap", path: "."

    if ENV['VAGRANT_DEFAULT_PROVIDER'] == 'vmware_fusion'
        gem "vagrant-vmware-fusion"
    end
end
