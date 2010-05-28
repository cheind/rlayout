#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout

  # Structure to hold a node and its parent tag
  NodeTagPair = Struct.new(:node, :parent_tag)
  
  # Preorder traveral of tree starting at given node.
  # Traversal is performed iteratively.
  def RLayout.vfs_preorder(root, init_tag, &block)
    stack = []
    stack.push(NodeTagPair.new(root, init_tag))
    while (!stack.empty?)     
      ntp = stack.pop
      node_tag = block.call(ntp.node, ntp.parent_tag)
      if ntp.node.instance_of?(VFSGroup)
        ntp.node.nodes.each_value do |node|
          stack.push(NodeTagPair.new(node, node_tag))
        end
      end
    end
  end
  
end