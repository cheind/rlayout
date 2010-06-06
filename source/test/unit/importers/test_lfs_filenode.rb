#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'test/unit/rlayout'
require 'rlayout'
include RLayout



module Importers
  class TestLFSFileNode < Test::Unit::TestCase
    
    def test_existing_file
      n = LFSFileNode.new('a.txt', 'etc/testdb/a.txt')
      assert_equal('a.txt', n.name)
      assert_not_nil(n.filepath.index('etc/testdb/a.txt'))
      assert_read_node(n, 2, 'a: Hello World!', 10)
    end
    
    def test_nonexisting_file
      n = LFSFileNode.new('a.txt', 'etc/testdb/missing.txt')
      assert_raise Errno::ENOENT do 
        assert_read_node(n, 1, 'a: Hello World!', 10)
      end
    end
  end
end
