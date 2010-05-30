#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'fileutils'

module RLayout
  module Exporters
  
    # Exports the content of the VFS to a local directory.
    class LFSDirectory < Exporter
      
      # Initialize with directory path to generate to
      def initialize(directory_path, opts = {})
        @opts = {:dry_run => false, :delete_if_existing => false, :chunksize => 1024 }.merge(opts)
        @dir_path = File.expand_path(directory_path)        
        @chunksize = @opts[:chunksize]
      end
      
      def prologue(root)
        
        fu_mode.mkdir_p(@dir_path)
        @clean_up_path = File.join(@dir_path, root.name)
        cleanup if @opts[:delete_if_existing]
        @dir_path
      end
      
      def process(node, parent_path)
        mypath = File.join(parent_path, node.name)
        self.process_node(mypath, node)
      end
      
      def epilogue
      end
      
      def cleanup
        fu_mode::rm_rf(@clean_up_path) if File.exist?(@clean_up_path)
      end
     
      protected
      
      # Process a single node
      def process_node(path, node)
        if node.kind_of?(VFSGroup)
          fu_mode.mkdir_p(path)
        else
          if (!@opts[:dry_run])
            File.open(path, "wb") do |ios|
              node.read_stream(@chunksize) { |bytes| ios.write(bytes) }
            end
          else
            puts "write #{path}"
          end
        end
      end
      
      # Fileutils mode.
      def fu_mode
        if (@opts[:dry_run])
          FileUtils::DryRun
        else
          FileUtils
        end
      end
      
    end
  
    def Exporters.lfs_directory(directory_path, opts = {})
      LFSDirectory.new(directory_path, opts)
    end
  
  end
end


