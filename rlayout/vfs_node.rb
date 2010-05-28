#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

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
    
    # Read content of node an pass to block
    def read_stream(chunksize_hint = 1024, &block)
      raise StreamingException.new("VFSNode cannot be streamed", nil)
    end
    
  end
  
end


