
module RLayout
  
  # A Node in the virtual file system whose content is streamable.
  # Currently all nodes providing custom content need to derive from this
  # class in order to make their content accessible for Exporters::Exporter.
  #
  class VFSStreamableNode < VFSNode
    
    # Initialize with name
    def initialize(name)
      super(name)
    end
    
    # Read the complete content of this node in chunks of
    # size <tt>chunksize_hint</tt>.
    # 
    # Resulting bytes are passed to the <tt>block</tt> argument.
    def read_stream(chunksize_hint = 1024, &block)
      raise Error, "VFSNode cannot be streamed"
    end
    
  end
  
end


