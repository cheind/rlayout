#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'test/unit/rlayout'
require 'rlayout'
include RLayout

module Importers
  class TestOSExecNode < Test::Unit::TestCase
    
    def test_exisiting_page
      n = HttpFileNode.new('a.txt', URI.parse('http://rlayout.googlecode.com/svn/trunk/source/etc/testdb/a.txt'))
      assert_equal('a.txt', n.name)
      assert_read_node(n, 1, 'a: Hello World!', 10)
    end
    
    def test_nonexisting_page
      n = HttpFileNode.new('a.txt', URI.parse('http://iam.not.here/for/sureadsres.html'))
      assert_raise SocketError do 
        assert_read_node(n, 1, 'a: Hello World!', 10)
      end
    end
  end
end
