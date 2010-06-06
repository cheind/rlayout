#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'test/unit/rlayout'
require 'rlayout'
include RLayout

module Importers
  class TestMemTextNode < Test::Unit::TestCase
    
    def test
      n = MemTextNode.new('blub.txt', 'blub: Hello World!')
      assert_equal('blub.txt', n.name)
      assert_read_node(n, 2, 'blub: Hello World!', 10)
    end
  end
end
