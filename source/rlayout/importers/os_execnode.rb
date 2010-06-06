module RLayout
  module Importers
  
    # Execute process and capture output.
    class OSExecNode < VFSStreamableNode
      # Command to be executed
      attr_reader :command
      
      # Initialize with +name+ and +command+ string.
      def initialize(name, command)
        super(name)
        @command = command
      end
      
      # Invoke command and capture output
      def read_stream(chunksize_hint, &block)
        IO.popen(@command, "r") do |ios|
          while bytes = ios.read(chunksize_hint)
            block.call(bytes)
          end
        end
      end
    end
    
  end
end


