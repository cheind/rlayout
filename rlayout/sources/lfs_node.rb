#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Sources
  
    # Leaf node pointing to a local file.
    class LFSNode < VFSNode
      
      # Initialize 
      def initialize(name, filepath)
        super(name)
        @filepath = File.expand_path(filepath)
      end
      
      # Read file in chunks.
      def read_stream(chunksize_hint, &block)
        File.open(@filepath, "rb") do |ios|
          block.call(ios.read(chunksize_hint))
        end
      end
    end
    
  end
end


