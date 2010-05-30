#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  
  # A Node in the virtual file system whose content can be streamed
  class VFSStreamableNode < VFSNode
    
    # Initialize 
    def initialize(name)
      super(name)
    end
    
    # Read the complete content of this node.
    # The content is handed to the block argument in chunks,
    # in chunksize_hint bytes per chunk if possible.
    def read_stream(chunksize_hint = 1024, &block)
      raise StreamingError, "VFSNode cannot be streamed"
    end
    
  end
  
end


