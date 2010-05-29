#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Importers
  
    def Sources.lfs_file(filename, destname = File.basename(filename))
      raise ImportingException.new("File '#{filename}' not readable", nil) unless File.readable?(filename)
      LFSNode.new(destname, filename)
    end
    
  end
end


