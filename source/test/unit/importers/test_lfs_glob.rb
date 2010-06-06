#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

module Importers
  class TestLFSGlob < Test::Unit::TestCase
    def test_non_recursive
      n = Importers.lfs_glob('etc/testdb/a/a*.txt')
      assert_instance_of(Array, n)
      assert_equal(2, n.length)
      
      assert_instance_of(LFSFileNode, n[0])
      assert_equal('a0.txt', n[0].name)
      assert_instance_of(LFSFileNode, n[1])
      assert_equal('a1.txt', n[1].name)
    end
    
    def test_recursive
      n = Importers.lfs_glob('etc/testdb/**/a*')
      assert_instance_of(Array, n)
      assert_equal(3, n.length)
      
      assert_instance_of(VFSGroup, n[0])
      assert_equal(1, n[0].nodes.length)
      assert_instance_of(LFSFileNode, n[0]['a0.txt'])
      assert_instance_of(VFSGroup, n[1])
      assert_equal(1, n[1].nodes.length)
      assert_instance_of(LFSFileNode, n[1]['a1.txt'])
      assert_instance_of(LFSFileNode, n[2])
      assert_equal('a.txt', n[2].name)
    end
  end
end
