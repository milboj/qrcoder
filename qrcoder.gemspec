# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name        = "qrcoder"
  s.summary     = "Creates QR code files "
  s.description = "Render QR codes in png and svg format. This is fork of sam vincent rqrcode-rails3"
  
  s.files       = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.md"]
  
  s.author      = "Bojan Milosavljevic"
  s.email       = "milboj@gmail.com"
  s.homepage    = "http://github.com/samvincent/rqrcode-rails3"
  s.version     = "0.1"
  
  s.add_dependency 'rqrcode', '>= 0.4.2'
  s.add_dependency 'mini_magick', '>= 3.0'
end
