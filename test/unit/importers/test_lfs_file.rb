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
      n = Importers.lfs_file('rlayout/exporters.rb')
      assert_instance_of(LFSFileNode, n)
      assert_equal('exporters.rb', n.name)
      assert_not_nil(n.filepath.index('rlayout/exporters.rb'))
    end
    
    def test_filelist
      n = Importers.lfs_filelist('rlayout/exporters.rb', 'rlayout/importers.rb', 'not-here')
      assert_instance_of(Array, n)
      assert_equal(3, n.length)
      
      assert_instance_of(LFSFileNode, n[0])
      assert_equal('exporters.rb', n[0].name)
      assert_not_nil(n[0].filepath.index('rlayout/exporters.rb'))
      
      assert_instance_of(LFSFileNode, n[1])
      assert_equal('importers.rb', n[1].name)
      assert_not_nil(n[1].filepath.index('rlayout/importers.rb'))
      
      assert_instance_of(LFSFileNode, n[2])
      assert_equal('not-here', n[2].name)
      assert_not_nil(n[2].filepath.index('not-here'))
      
    end
  end
end
