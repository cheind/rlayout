
module RLayout
  module Importers
  
    # Leaf node pointing to a local file.
    class LFSFileNode < VFSStreamableNode
      # Filepath
      attr_reader :filepath
      
      # Initialize with +name+ and +filepath+.
      def initialize(name, filepath)
        super(name)
        @filepath = File.expand_path(filepath)
      end
      
      # Read file in chunks.
      def read_stream(chunksize_hint, &block)
        File.open(@filepath, "rb") do |ios|
          bytes = ios.read(chunksize_hint)
          block.call(bytes) unless bytes.nil?
        end
      end
    end
    
  end
end


