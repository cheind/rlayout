# encoding: iso8859-1
# Above comment is a magic comment and defines the charset for the following script

require 'test/unit'
require 'rlayout'
include RLayout

class TestNonUTF8Support < Test::Unit::TestCase
  
  def test_non_utf8_support
    # See top of script for a magic comment
    a = VFSGroup.new('')
    a['€ßäöü']['$%']
    
    str = ''
    RLayout.vfs_preorder(a) do |n|
      str += n.name
    end
    assert_equal('€ßäöü$%', str)
  end
end
