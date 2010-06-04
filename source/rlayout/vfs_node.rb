
module RLayout
  
  # A Node in the virtual file system
  class VFSNode
    # Name of node
    attr_reader :name
    
    # Initialize with +name+.
    def initialize(name)
      @name = name
    end
    
    # Human readable inspection of node.
    # Prints entire subtree if this node has children.
    def inspect
      str = ''
      RLayout.vfs_preorder(self, 0) do |node, node_indent|
        str += ' '*node_indent + node.to_s + $/
        node_indent + 2
      end
      str.chomp
    end
    
    # Convert node to string
    def to_s
       "#{@name} : #{self.class}" 
    end
  end
  
end


