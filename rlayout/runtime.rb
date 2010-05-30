#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

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
        :log => Logger.new(STDOUT), 
        :log_level => Logger::INFO,
        :print_stats => true,
        :cleanup_on_error => true
      }.merge(opts)
      
      @logger = @opts[:log]
      @logger.level = @opts[:log_level]
      @logger.progname = 'RLayout'
      @logger.formatter = ErrorFormatter.new
      @exporters  = []
    end
    
    # Export starting from node
    def run(root)
      @logger.info('Starting.')
      begin
        init_tags = self.prologue(root)
        RLayout.vfs_preorder(root, init_tags) do |node, tags|
          self.process(node, tags)
        end
        self.epilogue
      rescue StandardError => err
        @logger.fatal("#{@failed_exporter ? @failed_exporter.class : RLayout.class} : #{err.message}")
        if @opts[:cleanup_on_error]
          @logger.info('Cleaning up.')
          self.cleanup
        end
        @logger.info('Aborting.')
        -1
      else
        @logger.info('Finished.')
        0
      end
    end
    
    protected
    
    def prologue(root)
      # Invoke exporters prologue
      init_tags = []
      @exporters.each do |e|
        begin
          init_tags << e.prologue(root)
        rescue StandardError => err
          @failed_exporter = e
          raise err
        end
      end
      init_tags
    end
    
    def process(node, tags)
      next_tags = []
      @exporters.each_with_index do |e, i|
        begin
          next_tags << e.process(node, tags[i])
        rescue StandardError => err
          @failed_exporter = e
          raise err
        end
      end
      next_tags
    end
    
    def epilogue
      @exporters.each do |e|
        begin
          e.epilogue
        rescue StandardError => err
          @failed_exporter = e
          raise err
        end
      end
    end
    
    def cleanup
      @exporters.each do |e|
        begin
          e.cleanup
        rescue StandardError => err
          @logger.fatal("#{e.class} : #{err.message}")
        end
      end
    end
    
  end
  
end
