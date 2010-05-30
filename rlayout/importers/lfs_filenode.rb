#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Importers
  
    # Leaf node pointing to a local file.
    class LFSFileNode < VFSStreamableNode
      attr_reader :filepath
      
      # Initialize with VFS name and local filepath.
      def initialize(name, filepath)
        super(name)
        @filepath = File.expand_path(filepath)
      end
      
      # Read file in chunks.
      def read_stream(chunksize_hint, &block)
        begin
          File.open(@filepath, "rb") do |ios|
            bytes = ios.read(chunksize_hint)
            block.call(bytes) unless bytes.nil?
          end
        rescue SystemCallError => e
          raise StreamingError, e.message
        end
      end
    end
    
  end
end


