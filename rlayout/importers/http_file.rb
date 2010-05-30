
require 'uri'

module RLayout
  module Importers
  
    # Import _uri_ from  HTTP _uri_
    def Importers.http_file(uri, opts = {})
      uri = URI.parse(uri) unless uri.instance_of?(URI)
      myopts = {:node_name => File.basename(uri.to_s)}.merge(opts)
      HttpFileNode.new(myopts[:node_name], uri, opts)
    end
  end
end


