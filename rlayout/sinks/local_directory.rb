#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Sinks
  
    # Generates output to a local directory
    class LocalDirectory
      
      # Initialize with directory path to generate to
      def initialize(directory_path, opts = {:force = > true })
        dir_path = File.expand_path(directory_path)
        if (File.directory?(dir_path))
          raise SinkingException.new("Directory '#{directory_path}' already exists." unless opts[:force]
          FileUtils.rm_rf(dir_path)
        end
        FileUtils.mkdir_p(dir_path)
      end
      
      # Generate to local directory
      def generate(root)
        
      end
    end
  
    
    
  end
end


