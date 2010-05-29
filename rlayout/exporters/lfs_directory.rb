#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'fileutils'

module RLayout
  module Exporters
  
    # Generates output to a local directory
    class LocalDirectory
      
      # Initialize with directory path to generate to
      def initialize(directory_path, opts = {})
        @opts = {:delete_if_existing => false, :chunksize => 1024 }.merge(opts)
        @dir_path = File.expand_path(directory_path)        
      end
      
      # Generate to local directory
      def generate(root)
        FileUtils.mkdir_p(@dir_path)
        clean_destination(root)
        chunksize = @opts[:chunksize]
        RLayout.vfs_preorder(root, @dir_path) do |node, parent_path|
          mypath = File.join(parent_path, node.name)
          if node.kind_of?(VFSGroup)
            FileUtils.mkdir_p(mypath)
          else
            File.open(mypath, "wb") do |ios|
              node.read_stream(chunksize) { |bytes| ios.write(bytes) }
            end
          end
        end
      end
      
      private
      
      def clean_destination(root)
        root_path = File.join(@dir_path, root.name)
        if (@opts[:delete_if_existing] && File.exist?(root_path))
          FileUtils.rm_rf(root_path)
        end
      end
    end
    
    def Exporters.lfs_directory(root, directory_path, opts = {})
      ld = LocalDirectory.new(directory_path, opts)
      ld.generate(root)
    end
  
  end
end


