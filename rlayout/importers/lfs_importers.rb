#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Importers
  
    # Import _filepath_ to the vfs.
    def Importers.lfs_file(filepath, destname = File.basename(filename))
      raise ImportingException.new("File '#{filepath}' not readable", nil) unless File.readable?(filepath)
      LFSNode.new(destname, filepath)
    end
    
  end
end


