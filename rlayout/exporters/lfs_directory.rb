
require 'fileutils'

module RLayout
  module Exporters
  
    # Exports the content of the VFS to a local directory.
    class LFSDirectory < Exporter
      
      # Write node content to local file.
      class MyStreamHandler < StreamHandler
        def initialize(output_path)
          @path = output_path
        end
        
        def open(node)
          @ios = File.new(@path, 'wb')
        end
        
        def write(bytes)
          @ios.write(bytes)
        end
        
        def close(node)
          @ios.close if @ios
        end
      end
      
      # Initialize with directory path to generate to
      def initialize(directory_path, opts = {})
        @opts = {:dry_run => false, :delete_if_existing => false, :chunksize => 1024 }.merge(opts)
        @dir_path = File.expand_path(directory_path)
      end
      
      def prologue(root)
        fu_mode.mkdir_p(@dir_path)
        @clean_up_path = File.join(@dir_path, root.name)
        cleanup if @opts[:delete_if_existing]
        @dir_path
      end
      
      def group(node, parent_path)
        path = File.join(parent_path, node.name)
        fu_mode.mkdir_p(path)
        path
      end
      
      def leaf(node, parent_path)
        path = File.join(parent_path, node.name)
        handler = nil
        if (!@opts[:dry_run])
          handler = MyStreamHandler.new(path)
        else
          puts "write #{path}"
        end
        handler
      end
      
      def epilogue
      end
      
      def cleanup
        fu_mode::rm_rf(@clean_up_path) if File.exist?(@clean_up_path)
      end
     
      protected
      
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


