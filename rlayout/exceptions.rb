#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  # Base RLayout error type
  class Error < RuntimeError; end
  # Streaming data failed
  class StreamingError < Error; end
  # Importing of content failed
  class ImportingError < Error; end
  # Exporting data failed.
  class ExportingError < Error; end
end


