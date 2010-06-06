
require 'stringio'

module RLayout
  module Importers
  
    # Leaf node pointing to a streamable text in memory.
    class MemTextNode < VFSStreamableNode
      # Text content
      attr_reader :text
      
      # Initialize with +name+ and +text+.
      def initialize(name, text)
        super(name)
        @text = text.to_s
      end
      
      # Read text in chunks.
      def read_stream(chunksize_hint, &block)
        StringIO.open(@text, "rb") do |ios|
          while bytes = ios.read(chunksize_hint)
            block.call(bytes)
          end
        end
      end
      
    end
    
  end
end


