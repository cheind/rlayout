#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout

  class SinkingException < RuntimeError
    attr_reader :inner_exception
    
    def initialize(message, inner_exception = nil)
      super(message)
      @inner_exception = inner_exception
    end
  end
  
end


