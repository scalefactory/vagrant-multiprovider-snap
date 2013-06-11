# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vagrant-snap/version"

Gem::Specification.new do |s|
  s.name        = "vagrant-snap"
  s.version     = Vagrant::Snap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jon Topper"]
  s.email       = ["jon@scalefactory.com"]
  s.homepage    = "http://github.com/scalefactory/vagrant-snap"

  s.summary     = %q{Multi-provider snapshots for Vagrant}
  s.description = %q{Multi-provider snapshots for Vagrant}

  s.rubyforge_project = "vagrant-snap"

  files = `git ls-files`.split("\n")
  ignore = %w{rgloader/* Gemfile Rakefile Vagrantfile .gitignore}

  files.delete_if do |f|
      ignore.any? do |i|
          File.fnmatch(i, f, File::FNM_PATHNAME) ||
          File.fnmatch(i, File.basename(f), File::FNM_PATHNAME)
      end
  end

  s.files         = files
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

end
