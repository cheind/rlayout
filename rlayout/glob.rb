#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

# Glob all files from pattern.
#
# If pattern contains a recursive globbing expression, this method 
# creates sub-nodes and assigns files accordingly. Sub-nodes are created for
# all directory chains found after the first recursive globbing
# expression (**).
#
# Return array of globbed files for destination node
def glob(pattern, opts = {})
  opts = { :sub_nodes => false }.merge(opts)
  exp_path = File.expand_path(pattern)
  i = exp_path.index("**")
  content = []
  if i && opts[:sub_nodes]
    Dir.glob(exp_path).each do |fp|
      fp_rest = fp[i..-1]
      splitted = fp_rest.split("/")
      if (splitted.length > 1)
        # Need to create chain of sub-nodes, last one is skipped (basename)
        lp = l = Node.new(splitted[0])
        splitted[1..-2].each do |sub_node|
          # Invoke creator on node. Use [] to support special chars
          # such as whitespaces
          l = l[sub_node]
        end
        l << fp
        content << lp
      else
        content << fp
      end
    end
  else
    # No recursive pattern
    content += Dir.glob(pattern)
  end
  content
end


