
require 'net/http'
require 'net/https'
require 'uri'

module RLayout
  module Importers
  
    # Leaf node pointing to a file hosted on an HTTP/HTTPS server.
    class HttpFileNode < VFSStreamableNode
      # URI to file
      attr_reader :uri
      
      # Initialize from +name+, +uri+ and options +opts+.
      #
      # === Supported Options
      # * <tt>:basic_auth_user</tt> - Username used for authentication with server.
      # * <tt>:basic_auth_password</tt> - Password used for authentication with server.
      #
      def initialize(name, uri, opts = {})
        super(name)
        @uri = uri
        @opts = opts
      end
      
      # Read file in chunks.
      def read_stream(chunksize_hint, &block)       
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.use_ssl = (@uri.scheme == 'https' || @uri.port == 443)
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        req = Net::HTTP::Get.new(@uri.select(:path, :query).join(''))
        req.basic_auth(
            @opts[:basic_auth_user], 
            @opts[:basic_auth_password]
          )
        http.request(req) do |response|
          response.read_body(&block)
        end
      end
    end
    
  end
end


