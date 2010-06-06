#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
require 'rlayout/exporters/lfs_zipfile'
include RLayout

class TestAcceptanceRuntime < Test::Unit::TestCase
    
  def xtest_lfs
    r = RLayout.vfs_group('release')
    r.a << Importers.lfs_glob('rlayout/**/e*.rb')
    
    runtime = Runtime.new
    runtime.exporters << Exporters.lfs_directory('c:/temp/')
    runtime.run(r, :dry_run => true)
  end
  
  def xtest_zip
    r = RLayout.vfs_group('release')
    r.a << Importers.lfs_glob('rlayout/**/e*.rb')
    
    runtime = Runtime.new
    runtime.exporters << Exporters.lfs_zipfile('c:/temp/myzip.zip')
    runtime.run(r, :dry_run => true)
  end
  
  def xtest_text
    r = Importers.mem_text('readme.txt', <<eos)
Here goes your text. 
Maybe some more text.
eos
    
    runtime = Runtime.new
    runtime.exporters << Exporters.lfs_directory('c:/temp/')
    runtime.run(r, :dry_run => false)
  end
  
  def test_os
    r = Importers.os_exec('changelog', 'svn log', :args => ['http://rlayout.googlecode.com/svn/trunk'])
    runtime = Runtime.new
    runtime.exporters << Exporters.lfs_directory('c:/temp/hugo')
    runtime.run(r, :dry_run => false)
    
    
    
  end
  
  
end