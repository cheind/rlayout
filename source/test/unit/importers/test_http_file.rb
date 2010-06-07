#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

module Importers
  class TestHttpFile < Test::Unit::TestCase
    def test
      n = Importers.http_file('http://rlayout.googlecode.com',  :node_name => 'index.htm')
      assert_instance_of(HttpFileNode, n)
      assert_equal('index.htm', n.name)
    end
  end
end
