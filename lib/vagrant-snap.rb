require "vagrant-snap/version"
require "vagrant-snap/plugin"

module VagrantSnap
   def self.source_root
      @source_root ||= Pathname.new(File.expand_path("../../", __FILE__))
   end
end
