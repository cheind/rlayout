#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Importers
  
    # Import _filepath_ from the local file system.
    def Importers.lfs_file(filepath, nodename = File.basename(filepath))
      LFSFileNode.new(nodename, filepath)
    end
    
    # Import all files from _filelist_ from the local file system.
    def Importers.lfs_filelist(*filelist)
      nodes = []
      filelist.each do |path|
        name = File.basename(path)
        nodes << LFSFileNode.new(name, path)
      end
      nodes
    end
    
  end
end


