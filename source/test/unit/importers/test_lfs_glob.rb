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
      n = Importers.lfs_glob('rlayout/e*.rb')
      assert_instance_of(Array, n)
      assert_equal(2, n.length)
      
      assert_instance_of(LFSFileNode, n[0])
      assert_equal('exceptions.rb', n[0].name)
      assert_not_nil(n[0].filepath.index('rlayout/exceptions.rb'))
      
      assert_instance_of(LFSFileNode, n[1])
      assert_equal('exporters.rb', n[1].name)
      assert_not_nil(n[1].filepath.index('rlayout/exporters.rb'))
    end
    
    def test_recursive
      n = Importers.lfs_glob('rlayout/**/*node.rb')
=begin
      assert_instance_of(Array, n)
      assert_equal(2, n.length)
      
      assert_instance_of(LFSFileNode, n[0])
      assert_equal('exceptions.rb', n[0].name)
      assert_not_nil(n[0].filepath.index('rlayout/exceptions.rb'))
      
      assert_instance_of(LFSFileNode, n[1])
      assert_equal('exporters.rb', n[1].name)
      assert_not_nil(n[1].filepath.index('rlayout/exporters.rb'))
=end
    end
  end
end
