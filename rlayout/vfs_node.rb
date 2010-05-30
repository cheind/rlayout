
module RLayout
  
  # A Node in the virtual file system
  class VFSNode
    # Name of node
    attr_reader :name
    
    # Initialize 
    def initialize(name)
      @name = name
    end
    
    # Human readable inspection
    def inspect
      str = ""
      RLayout.vfs_preorder(self, 0) do |node, node_indent|
        str += ' '*node_indent + node.to_s + "\n"
        node_indent + 2
      end
      str
    end
    
    # Convert to string
    def to_s
       "#{@name} : #{self.class}" 
    end
    
    # Read the complete content of this node.
    # The content is handed to the block argument in chunks,
    # in chunksize_hint bytes per chunk if possible.
    def read_stream(chunksize_hint = 1024, &block)
      raise StreamingError, "VFSNode cannot be streamed"
    end
    
  end
  
end


