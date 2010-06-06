
module RLayout
  module Importers
  
    # Import the ouptut of a command executed on the local OS.
    #
    # === Supported Options
    # * <tt>:args</tt> - Array of arguments passed with command. Commands are quote-escaped before passed to the OS.
    def Importers.os_exec(nodename, command, opts={})
      myopts = {:args => []}.merge(opts)
      mycommand = command + " " +  
        myopts[:args].map{|e| "\"#{e}\""}.join(' ')
      OSExecNode.new(nodename, mycommand)
    end
    
  end
end


