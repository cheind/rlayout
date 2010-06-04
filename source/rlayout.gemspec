#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'rubygems'
require 'rake'

spec = Gem::Specification.new do |s|
  s.name = 'rlayout'
  s.version = '1.0.0'
  s.summary = 'Simplify creating file bundles.'
  s.author = 'Christoph Heindl'
  s.email = 'christoph.heindl@gmail.com'
  s.homepage = 'http://code.google.com/p/rlayout/'
  s.description = 'Simplify creating packages from files and folders.'
  s.require_path = '.'
  s.files = FileList['rlayout.rb', 'License', 'README', 'Rakefile', 'rlayout/**/*.rb', 'test/**/*', 'example/**/*'].to_a
  s.test_files = FileList['test/unit/*'].to_a
  s.has_rdoc = true
  s.extra_rdoc_files = ['README', 'License']
  s.rdoc_options << '--title' << 'RLayout -- Simplify packaging' << 
                           '--main' << 'README' <<
                           '-x' << 'test/*' << '-x' << 'example/*'
end


