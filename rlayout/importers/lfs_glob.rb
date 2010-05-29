#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Importers
    
    # Import all files matching globbing pattern _pattern_
    #
    # If pattern contains a recursive globbing expression, this method 
    # creates sub-nodes and assigns files accordingly. Sub-nodes are created for
    # all directory chains found after the first recursive globbing
    # expression (**).
    def Importers.lfs_glob(pattern, opts = {})
      gh = GlobbingHelper.new(pattern, opts)
      gh.glob
    end
    
    # Supports enumerating files matching a globbing pattern.
    class GlobbingHelper
      def initialize(pattern, opts)
        @opts = {:flatten_recursive => false}.merge(opts)
        @pattern = File.expand_path(pattern)
      end
      
      # Glob files
      def glob
        nodes = []
        # Detect first recursive sub-pattern
        i = @pattern.index('**')
        split_enabled = i && !@opts[:flatten_recursive]
        Dir.glob(@pattern).each do |fp|
          if split_enabled
            nodes << split_path(fp, i)
          else
            nodes << LFSFileNode.new(File.basename(fp), fp)
          end
        end
        nodes
      end
      
      # Split a path at the first recursive globbing expression
      # and create a chain of virtual sub groups and a single
      # LFSFileNode for it.
      def split_path(fp, i)
        n = LFSFileNode.new(File.basename(fp), fp)
        fp_rest = fp[i..-1]
        splitted = fp_rest.split("/")
        if splitted.length > 1
          # Need to create chain of sub-nodes, last one is skipped (basename)
          lp = l = VFSGroup.new(splitted[0])
          splitted[1..-2].each do |sub_node|
            # Invoke creator on node. 
            # Use [] to support special characters such as whitespaces
            l = l[sub_node]
          end
          # Attach file node as leaf to directory chain
          l.add_child(n)
          n = lp
        end
        n
      end
    end
    
  end
end


