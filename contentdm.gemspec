require 'rake'

spec = Gem::Specification.new do |s|
  s.platform  =   Gem::Platform::RUBY
  s.name      =   "contentdm"
  s.version   =   "0.3.1"
  s.author    =   "Derek Kastner"
  s.email     =   "dkastner@gmail.com"
  s.summary   =   "Interface with ContentDM content management system"
  s.files     =   FileList['lib/**/*.rb'].to_a
  s.require_path  =   "lib"
  s.test_files = Dir.glob('spec/**/*') + Dir.glob('features/**/*')
  s.has_rdoc  =   true
  
  s.add_dependency('curb-fu', '>= 0.2.1')
  s.add_dependency('memcache-client')
end
