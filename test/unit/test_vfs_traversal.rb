#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

class TestVFSTravesal < Test::Unit::TestCase
   
  def test_traversal
    a = VFSGroup.new('a')
    b = VFSGroup.new('b')
    c = VFSGroup.new('c')
    d = VFSGroup.new('d')
    e = VFSGroup.new('e')
    f = VFSGroup.new('f')
    g = VFSGroup.new('g')
    
    a.add_child(b)
    b.add_child(c)
    a.add_child(f)
    
    b.add_child(d)
    d.add_child(e)
    f.add_child(g)
    
    str = ''
    depths = {}
    RLayout.vfs_preorder(a, 0) do |n, depth|
      str += n.name
      depths[n.name] = depth
      depth + 1
    end
    
    assert_equal('abcdefg', str)
    assert_equal(depths, {'a' => 0, 'b' => 1, 'f' => 1, 'c' => 2, 'd' => 2, 'e' => 3, 'g' => 2})   
  end
end
