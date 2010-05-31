
require 'fileutils'

module RLayout
  module Exporters
  
    # Base class for exporters cooperating with RLayout.Runtime
    class Exporter
      
      # Exporting of virtual file system is about to start.
      # Value returned is taken as initial tag for the +root+ node.
      #
      # === Supported Options
      #  * <tt>:dry_run</tt> - Run without writing data but with verbose output.
      def prologue(node, opts)
      end
      
      # Exporting of virtual file system finished.
      def epilogue
      end
      
      # Process a group +node+ along with its associated +tag+.
      # Value returned is considered the tag for the children of +node+.
      def group(node, tag)
      end
      
      # Process a streamable leaf.
      # Return a StreamHandler if exporter is interested in dealing with
      # the content of the +node+. +tag+ is the associated tag with +node+.
      def leaf(node, tag)
      end
      
      # Process any other node that directly inherits from VFSNode
      # and whose class does not match VFSGroup or VFSStreamableNode.
      def other(node, tag)
      end
      
      # Remove any generated output.
      def cleanup
      end
    end
    
    # Base class for handling streamable nodes at exporters
    class StreamHandler
      # Open output for node
      def open(node)
      end
      
      # Write bytes to output
      def write(bytes)
      end
      
      # Close output for node
      # Always called even if error occurred.
      def close(node)
      end
    end
  end
end


