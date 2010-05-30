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
        raise RuntimeError, "Not implemented"
      end
      
      # Called after exporting finished
      def epilogue
        raise RuntimeError, "Not implemented"
      end
      
      # Process _node_ and its _tag_.
      # Value returned from this method is taken as input tag for
      # child nodes of this _node_
      def process(node, tag)
        raise RuntimeError, "Not implemented"
      end
      
      # Called when cleanup of necessary generated output is required.
      def cleanup
        raise RuntimeError, "Not implemented"
      end
    end
  end
end


