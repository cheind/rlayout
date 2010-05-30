
require 'zip/zipfilesystem'

module RLayout
  module Exporters
  
    # Exports the content of the VFS to zip file saved on the local file system.
    # Requires _rubyzip_.
    class LFSZipFile < Exporter
      
      # Write node content to zip file
      class MyStreamHandler < StreamHandler
        def initialize(zipfile, path)
          @zipfile = zipfile
          @path = path
        end
        
        def open(node)
          @ios = @zipfile.file.new(@path, 'wb')
        end
        
        def write(bytes)
          @ios.write(bytes)
        end
        
        def close(node)
          @ios.close if @ios
        end
      end
      
      # Initialize with zip archive's filename
      def initialize(zipfilepath, opts = {})
        @opts = {:dry_run => false}.merge(opts)
        @filepath = File.expand_path(zipfilepath)
      end
      
      def prologue(root)
        fu_mode.rm_rf(@filepath) if File.exist?(@filepath)
        @zipfile = Zip::ZipFile.new(@filepath, true)
        ''
      end
      
      def group(node, parent_path)
        mypath = File.join(parent_path, node.name)
        if @opts[:dry_run]
          puts "mkdir #{mypath} in zip"
        else
          @zipfile.dir.mkdir(mypath)
        end
        mypath
      end
      
      def leaf(node, parent_path)
        mypath = File.join(parent_path, node.name)
        if @opts[:dry_run]
          puts "write #{mypath} in zip"
        else
          MyStreamHandler.new(@zipfile, mypath)
        end
      end
      
      def epilogue
        @zipfile.close
      end
      
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
  
    def Exporters.lfs_zipfile(zipfilepath, opts = {})
      LFSZipFile.new(zipfilepath, opts)
    end
  
  end
end


