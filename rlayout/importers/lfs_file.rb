
module RLayout
  module Importers
  
    # Import a single file from +filepath+ from the local file system.
    #
    # === Supported Options
    # * <tt>:node_name</tt> - Function that takes a file path and converts it to a node name.
    def Importers.lfs_file(filepath, opts = {})
      myopts = {:node_name => File.basename(filepath)}.merge(opts)
      LFSFileNode.new(RLayout.derive_name(myopts[:node_name], filepath), filepath)
    end
    
    # Import all local files from +filelist+.
    # If the last argument is a Hash it is considered an option hash.
    #
    # === Supported Options
    # * <tt>:node_name</tt> - Function that takes a file path and converts it to a node name.
    #
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


