require "vagrant-multiprovider-snap/version"
require "vagrant-multiprovider-snap/plugin"

module VagrantSnap
   def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
   end
end
