
module RLayout
  module Importers
  
    # Import a +text+ from memory.
    def Importers.mem_text(nodename, text)
      MemTextNode.new(nodename, text)
    end
    
  end
end


