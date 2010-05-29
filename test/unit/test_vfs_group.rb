#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

class TestVFSGroup < Test::Unit::TestCase
  
  def test_method_missing
    a = VFSGroup.new('a')
    a.b.c
    a.b.d.e
    a.f.g
    
    str = ''
    depths = {}
    RLayout.vfs_preorder(a, 0) do |n, depth|
      assert_instance_of(VFSGroup, n)
      str += n.name
      depths[n.name] = depth
      depth + 1
    end
    
    assert_equal('abcdefg', str)
    assert_equal(depths, {'a' => 0, 'b' => 1, 'f' => 1, 'c' => 2, 'd' => 2, 'e' => 3, 'g' => 2})   
  end
  
  class MyGroup < VFSGroup
    def initialize(name)
      super(name)
    end
    
    def empty?
      @nodes.empty?
    end
  end
  
  def test_method_missing_custom_group
    a = MyGroup.new('a')
    a.b.c
    
    str = ''
    RLayout.vfs_preorder(a, nil) do |n, unused|
      assert_instance_of(MyGroup, n)
      case n.name
        when 'a' 
          assert_equal(false, n.empty?)
        when 'b' 
          assert_equal(false, n.empty?)
        when 'c' 
          assert_equal(true, n.empty?)
      end
      str += n.name
      nil
    end
  end
  
  def test_index_operator
    a = MyGroup.new('a')
    a[" says hello, "]["world!##?$##"]
    str = ''
    RLayout.vfs_preorder(a) do |n|
      str += n.name
    end
    
    assert_equal("a says hello, world!##?$##", str)
  end
  
  def test_add_child
    a = MyGroup.new('a')
    a.b.c
    
    b = VFSGroup.new('b')
    b.c.d
    b.e
    
    f = VFSNode.new('f')
    
    assert_nothing_thrown do 
      a.add_child(nil)
    end
    
    a.add_child(b)
    a.add_child(f)
    
    str = ''
    types = {}
    RLayout.vfs_preorder(a) do |n|
      str += n.name
      types[n.name] = n.class
    end
    
    assert_equal('abcdef', str)
    assert_equal(
      {'a' => MyGroup, 
       'b' => MyGroup, 
       'c' => MyGroup, 
       'd' => VFSGroup, 
       'e' => VFSGroup, 
       'f' => VFSNode
      },
      types
    )
  end
  
  def test_child_nodes
    a = MyGroup.new('a')
    a.b.c
    
    b = VFSGroup.new('b')
    b.c.d
    b.e
    
    f = VFSNode.new('f')
    
    a << [b, f]
    
    str = ''
    types = {}
    RLayout.vfs_preorder(a) do |n|
      str += n.name
      types[n.name] = n.class
    end
    
    assert_equal('abcdef', str)
    assert_equal(
      {'a' => MyGroup, 
       'b' => MyGroup, 
       'c' => MyGroup, 
       'd' => VFSGroup, 
       'e' => VFSGroup, 
       'f' => VFSNode
      },
      types
    )
  end
end
