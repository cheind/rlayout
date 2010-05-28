#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Sinks
  
    # Generates output to a local directory
    class LocalDirectory
      
      # Initialize with directory path to generate to
      def initialize(directory_path, opts = {:force = > true, :chunksize => 1024 })
        @dir_path = File.expand_path(directory_path)
        if (File.directory?(@dir_path))
          raise SinkingException.new("Directory '#{directory_path}' already exists." unless opts[:force]
        end
        FileUtils.mkdir_p(@dir_path)
      end
      
      # Generate to local directory
      def generate(root)
        chunksize = opts[:chunksize]
        RLayout.vfs_preorder(root, @dir_path) do |node, parent_path|
          mypath = File.join(parent_path, @node.name)
          if node.instance_of?(VFSGroup)
            FileUtils.mkdir(mypath)
          else
            File.open(mypath, "wb") do |ios|
              node.read_stream(chunksize) { |bytes| ios.write(bytes) }
            end
          end
        end
      end
    end
  
    
    
  end
end


