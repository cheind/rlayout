
module RLayout

  # Structure to hold a node and its parent tag
  NodeTagPair = Struct.new(:node, :parent_tag)
  
  # Iterates in preorder starting at _root_. _block_ parameter is
  # called for each node visted.
  #
  # Each node can be associated with a tag which is passed to _block_ in
  # conjunction with the current node. If _block_ returns a tag it is associated
  # with all children of the current node. The tag associated with _root_ is
  # _init_tag_.
  #
  # === Example
  #  a = VFSGroup.new('a')
  #  a.b.c
  #
  #  str = ''
  #  depth = {}
  #  RLayout.vfs_preorder(a, 0) do |n, depth|
  #    depth[n.name] = depth
  #    depth + 1
  #  end
  #  
  #  str #=> 'abc'
  #  depth #=> {'a'=>0, 'b'=>1, 'c'=>2}
  #
  def RLayout.vfs_preorder(root, init_tag = nil, opts = {}, &block) # :yields: node, parent tag
    myopts = {:unroll_incomplete => true}.merge(opts)
    stack = []
    stack.push(NodeTagPair.new(root, init_tag))
    while (!stack.empty?)     
      ntp = stack.pop
      node_tag = nil
      # Support for blocks that just accept a node and blocks that accept a node and its tag.
      case block.arity
        when 1 then block.call(ntp.node)
        when 2 then node_tag = block.call(ntp.node, ntp.parent_tag)
      end
      if ntp.node.kind_of?(VFSGroup)
        subnodes = ntp.node.nodes.values
        if ntp.node.incomplete? && myopts[:unroll_incomplete]
          tmp_node = VFSGroup.new('temporary')
          tmp_node.add_children(subnodes)
          tmp_node.add_children(ntp.node.unroll)
          subnodes = tmp_node.nodes.values
        end
        # Push subnodes in reverse order so that they arrive in-order
        subnodes.reverse.each do |node|
          stack.push(NodeTagPair.new(node, node_tag))
        end
      end
    end
  end
  
end