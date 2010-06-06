#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

module Importers
  class TestMemText < Test::Unit::TestCase
    def test
      n = Importers.mem_text('hugo.txt', 'Hello World')
      assert_instance_of(MemTextNode, n)
      assert_equal('hugo.txt', n.name)
      assert_equal('Hello World', n.text)
    end
  end
end
