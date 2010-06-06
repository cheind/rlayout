#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

module Importers
  class TestLFSFile < Test::Unit::TestCase
    def test_existing_file
      n = Importers.lfs_file('etc/testdb/a.txt')
      assert_instance_of(LFSFileNode, n)
      assert_equal('a.txt', n.name)
      assert_not_nil(n.filepath.index('etc/testdb/a.txt'))
    end
    
    def test_filelist
      n = Importers.lfs_filelist('etc/testdb/a/a0.txt', 'etc/testdb/a/a1.txt', 'not-here')
      assert_instance_of(Array, n)
      assert_equal(3, n.length)
      
      assert_instance_of(LFSFileNode, n[0])
      assert_equal('a0.txt', n[0].name)
      assert_not_nil(n[0].filepath.index('etc/testdb/a/a0.txt'))
      
      assert_instance_of(LFSFileNode, n[1])
      assert_equal('a1.txt', n[1].name)
      assert_not_nil(n[1].filepath.index('etc/testdb/a/a1.txt'))
      
      assert_instance_of(LFSFileNode, n[2])
      assert_equal('not-here', n[2].name)
      assert_not_nil(n[2].filepath.index('not-here'))
      
    end
  end
end
