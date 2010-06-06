#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

module Importers
  class TestOSExec < Test::Unit::TestCase
    def test
      n = Importers.os_exec('hugo', 'ruby', :args => ['-e', "print 'Hello World!'"])
      assert_instance_of(OSExecNode, n)
      assert_equal('hugo', n.name)
      assert_read_node(n, 2, 'Hello World!', 10)
    end
  end
end
