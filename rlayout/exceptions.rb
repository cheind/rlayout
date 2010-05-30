
module RLayout
  # Base RLayout error type
  class Error < RuntimeError; end
  # Fatal error, runtime aborts
  class FatalError < RuntimeError; end
  # Streaming data failed
  class StreamingError < Error; end
  # Importing of content failed
  class ImportingError < Error; end
  # Exporting data failed.
  class ExportingError < Error; end
end


