
require 'fileutils'

module RLayout
  module Exporters
  
    # Exports the content of the virtual file system to a local directory.
    #
    # === Mapping
    #  - Generates a directory for each VFSGroup
    #  - Generates a file for each VFSStreamableNode
    class LFSDirectory < Exporter
      
      # Write node content to local file.
      class MyStreamHandler < StreamHandler
        # Initialize with +output_path+
        def initialize(output_path)
          @path = output_path
        end
        
        # Open file for writing
        def open(node)
          @ios = File.new(@path, 'wb')
        end
        
        # Write bytes
        def write(bytes)
          @ios.write(bytes)
        end
        
        # Close file
        def close(node)
          @ios.close if @ios
        end
      end
      
      # Initialize from directory to export to and additional options.
      #
      # === Supported Options
      # * <tt>:delete_if_existing</tt> - Delete files/folders that conflict with names from export.
      #
      def initialize(directory_path, opts = {})
        @opts = {:delete_if_existing => false}.merge(opts)
        @dir_path = File.expand_path(directory_path)
      end
      
      # Prologue
      def prologue(root, opts)
        @opts.merge!(opts)
        fu_mode.mkdir_p(@dir_path)
        @clean_up_path = File.join(@dir_path, root.name)
        cleanup if @opts[:delete_if_existing]
        @dir_path
      end
      
      # Process group node
      def group(node, parent_path)
        path = File.join(parent_path, node.name)
        fu_mode.mkdir_p(path)
        path
      end
      
      # Process leaf node
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
      
      # Epilogue
      def epilogue
      end
      
      # Remove generated files
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
  
    # Export to a local file system directory.
    # === Supported Options
    # See options of LFSDirectory#new.
    def Exporters.lfs_directory(directory_path, opts = {})
      LFSDirectory.new(directory_path, opts)
    end
  
  end
end


