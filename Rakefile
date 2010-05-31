#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => [:test]

desc "Run unit tests"
Rake::TestTask.new("test") { |t|
  t.pattern = FileList['test/unit/**/test_*.rb']
  t.verbose = false
  t.warning = false
}

desc "Run acceptance tests"
Rake::TestTask.new("acceptance") { |t|
  t.pattern = FileList['test/acceptance/acc_*.rb']
  t.verbose = false
  t.warning = false
}

desc "Run benchmarks"
Rake::TestTask.new("benchmark") { |t|
  t.pattern = FileList['test/benchmark/benchmark_*.rb']
  t.verbose = false
  t.warning = false
}

desc "Generate rdoc documentation"
Rake::RDocTask.new do |rd|
  rd.title = "RLayout Documentation"
  rd.main = 'README'
  rd.options << '--line-numbers' << '--inline-source'
  rd.options << '-A cattr_accessor=object'
  rd.options << '--charset' << 'utf-8'
  rd.rdoc_dir = "doc_tmp"
  rd.rdoc_files.include('README', 'License', 'rlayout/**/*.rb')
end
