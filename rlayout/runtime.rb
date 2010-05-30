
require 'logger'

module RLayout

  # Parses the VFS tree and invokes any exporter.
  class Runtime
    attr_reader :exporters
    
    # Format log error messages
    class ErrorFormatter
      Format = 	"%5s -- %s\n"
      def call(severity, time, program_name, message)
        Format % [severity, message]
      end
    end
    
    def initialize(opts = {})
      @opts = {
        :chunksize => 1024,
        :log => Logger.new(STDOUT), 
        :log_level => Logger::INFO,
        :print_stats => true,
        :cleanup_on_error => true,
        :reraise_errors => true
      }.merge(opts)
      
      @chunksize = @opts[:chunksize]
      @logger = @opts[:log]
      @logger.level = @opts[:log_level]
      @logger.progname = 'RLayout'
      @logger.formatter = ErrorFormatter.new
      @exporters  = []
    end
    
    # Export starting from node
    def run(root)
      exit_code = 0
      @logger.info('Starting.')
      begin
        init_tags = self.prologue(root)
        RLayout.vfs_preorder(
          root, 
          init_tags,
          :unroll_incomplete => true, 
          &self.method(:process)
        )
        self.epilogue
        @logger.info('Finished.')
      rescue StandardError => err
        @logger.fatal(err.message)
        if @opts[:cleanup_on_error]
          @logger.info('Cleaning up.')
          self.cleanup
        end
        @logger.info('Failed.')
        exit_code = -1
        raise err if @opts[:reraise_errors]        
      end
      exit_code
    end
    
    protected
    
    def prologue(root)
      init_tags = []
      self.send_each(@exporters, :prologue, root) do |ret|
        init_tags << ret
      end
      init_tags
    end
    
    # Process a _node_ and associated tags per exporter.
    def process(node, tags)
      if node.kind_of?(VFSGroup)
        process_group(node, tags)
      elsif node.kind_of?(VFSStreamableNode)
        process_leaf(node, tags)
      else
        process_other(node)
      end
    end
    
    # Process a group _node_ with associated tags per exporter.
    # Returns a collection of tags for each exporter.
    def process_group(node, tags)
      next_tags = []
      @exporters.each_with_index do |e, i|
        next_tags << e.group(node, tags[i])
      end
      next_tags
    end
    
    def process_leaf(node, tags)
      handlers = []
      @exporters.each_with_index do |e, i|
        h = e.leaf(node, tags[i])
        handlers << h if h
      end
      self.send_each(handlers, :open, node)
      begin
        node.read_stream(@chunksize) do |bytes|
          self.send_each(handlers, :write, bytes)
        end
      ensure
        self.send_each(handlers, :close, node)
      end
    end
    
    def process_other(node, tags)
      @exporters.each_with_index do |e, i|
        e.other(node, tags[i])
      end
    end
    
    def epilogue
      self.send_each(@exporters, :epilogue)
    end
    
    def cleanup
      self.send_each(@exporters, :cleanup)
    end
    
    def send_each(collection, method_name, *args)
      collection.each do |e|
        result = e.send(method_name, *args)
        yield result if block_given?
      end
    end
    
  end
  
end
