
require 'zip/zipfilesystem'

module RLayout
  module Exporters
  
    # Exports the content of a virtual file system to a local zip file.
    # 
    # === Requirements
    # Requires +rubyzip+.
    #  gem install rubyzip
    #
    class LFSZipFile < Exporter
      
      # Write node content to zip file
      class MyStreamHandler < StreamHandler
        def initialize(zipfile, path)
          @zipfile = zipfile
          @path = path
        end
        
        # Open a new file inside the zip
        def open(node)
          @ios = @zipfile.file.new(@path, 'wb')
        end
        
        # Write bytes to zip
        def write(bytes)
          @ios.write(bytes)
        end
        
        # Close file.
        def close(node)
          @ios.close if @ios
        end
      end
      
      # Initialize with zip filename.
      def initialize(zipfilepath)
        @filepath = File.expand_path(zipfilepath)
      end
      
      # Prologue.
      def prologue(root, opts)
        @opts = opts
        fu_mode.rm_rf(@filepath) if File.exist?(@filepath)
        @zipfile = Zip::ZipFile.new(@filepath, true)
        ''
      end
      
      # Process group.
      def group(node, parent_path)
        mypath = File.join(parent_path, node.name)
        if @opts[:dry_run]
          puts "mkdir #{mypath} in zip"
        else
          @zipfile.dir.mkdir(mypath)
        end
        mypath
      end
      
      # Process leaf.
      def leaf(node, parent_path)
        mypath = File.join(parent_path, node.name)
        if @opts[:dry_run]
          puts "write #{mypath} in zip"
        else
          MyStreamHandler.new(@zipfile, mypath)
        end
      end
      
      # Epilogue.
      def epilogue
        @zipfile.close
      end
      
      # Remove generated zip file.
      def cleanup
        fu_mode.rm_rf(@filepath) if File.exist?(@filepath)
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
  
    # Export to a local zip file directory.
    # 
    # === Supported Options
    # None
    def Exporters.lfs_zipfile(zipfilepath, opts = {})
      LFSZipFile.new(zipfilepath)
    end
  
  end
end


