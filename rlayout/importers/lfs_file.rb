
module RLayout
  module Importers
  
    # Import _filepath_ from the local file system.
    def Importers.lfs_file(filepath, opts = {})
      myopts = {:node_name => File.basename(filepath)}.merge(opts)
      LFSFileNode.new(RLayout.derive_name(myopts[:node_name], filepath), filepath)
    end
    
    # Import all files from _filelist_ from the local file system.
    def Importers.lfs_filelist(*filelist)
      # Take into account that last argument could be options-hash
      myopts = {:node_name => Proc.new {|path|File.basename(path)} } 
      myopts = filelist.pop.merge(myopts) if filelist.last.instance_of?(Hash)
      nodes = []
      filelist.each do |path|
        nodes << LFSFileNode.new(
          RLayout.derive_name(myopts[:node_name], path), 
          path
        )
      end
      nodes
    end
    
  end
end


