
require 'uri'

module RLayout
  module Importers
  
    # Import file from an HTTP/HTTPS server.
    #
    # === Supported Options
    # Besides options of HttpFileNode#new the following options are supported.
    # * <tt>:node_name</tt> - Function that takes an http URI and converts it to a node name.
    def Importers.http_file(uri, opts = {})
      uri = URI.parse(uri) unless uri.instance_of?(URI)
      myopts = {:node_name => File.basename(uri.to_s)}.merge(opts)
      HttpFileNode.new(myopts[:node_name], uri, opts)
    end
  end
end


