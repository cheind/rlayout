#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  module Sources
  
    def Sources.local_file(filename, destname = File.basename(filename))
      raise SourcingException.new("File '#{filename}' not readable", nil) unless File.readable?(filename)
      LFSNode.new(destname, filename)
    end
    
  end
end


