#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'fileutils'

module RLayout
  module Exporters
  
    # Base class for exporters cooperating with RLayout.Runtime
    class Exporter
      # Called before exporting starts
      # Returned value is taken as initial tag for the root node.
      def prologue(node)
      end
      
      # Called after exporting finished
      def epilogue
      end
      
      # Process a group _node_ along with its associated _tag_.
      # Returning a value will assign that value to the children of _node_.
      def group(node, tag)
      end
      
      # Process a VFSStreamableNode leaf _node_.
      # Return a StreamHandler if exporter is interested in dealing with
      # the _node_'s content stream.
      def leaf(node, tag)
      end
      
      # Process any other node that directly inherits from VFSNode
      # and whose class does not match VFSGroup or VFSStreamableNode.
      def other(node, tag)
      end
      
      # Called when cleanup of necessary generated output is required.
      def cleanup
        raise RuntimeError, "Not implemented"
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


