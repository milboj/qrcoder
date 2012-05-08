# -*- encoding: utf-8 -*-                                                                                                                                
$:.push File.expand_path("../lib", __FILE__)

# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name        = "qrcoder"
  s.summary     = "Creates QR code files "
  s.description = "Creates QR code files in png, bmp, png, jpg, tif and svg file format. This is fork of sam vincent rqrcode-rails3"
  
  s.files       = Dir["{lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  
  s.author      = "Bojan Milosavljevic"
  s.email       = "milboj@gmail.com"
  s.homepage    = "http://github.com/milboj/qrcoder"
  s.version     = "0.1.2"

  s.add_development_dependency "rake"
  s.add_development_dependency("bundler", ">= 1.0.0")

  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md", "CHANGELOG", "LICENSE"]
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.add_dependency 'rqrcode', '>= 0.4.2'
  s.add_dependency 'mini_magick', '>= 3.0' 
  s.require_paths = ["lib"]
  
end
