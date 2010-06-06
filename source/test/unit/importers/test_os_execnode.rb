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
    
    def test_existing_command
      n = OSExecNode.new('ruby.txt', 'ruby -v')
      assert_equal('ruby.txt', n.name)
      str = ''; n.read_stream(10) {|data| str += data}
      assert_match(/^ruby/, str)
    end
    
    def test_nonexisting_command
      n = OSExecNode.new('dummy', 'ruxiosads')
      assert_raise Errno::ENOENT do 
        str = ''; n.read_stream(10) {|data| str += data}
      end
    end
  end
end
