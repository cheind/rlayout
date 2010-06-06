
module RLayout
  module Importers
  
    # Import the output of command executed on the local OS.
    #
    # === Supported Options
    # * <tt>:args</tt> - Array of arguments passed with command.
    def Importers.os_exec(nodename, command, opts={})
      myopts = {:args => []}.merge(opts)
      mycommand = command + " " +  myopts[:args].join(' ')
      OSExecNode.new(nodename, mycommand)
    end
    
  end
end


