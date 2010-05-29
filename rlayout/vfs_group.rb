#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  
  # A grouping node in the virtual file system.
  # 
  class VFSGroup < VFSNode
    # Sub-nodes as a hash of node name to node
    attr_reader :nodes
    
    # Initialize 
    def initialize(name)
      super(name)
      @nodes = {}
    end
    
    # Method missing event triggers creation of sub-node
    def method_missing(method_name, *args)
      get_or_create_node(method_name.to_s, true)
    end 
    
    # Access or create nodes with otherwise invalid characters.
    def [](name)
      get_or_create_node(name.to_s, false)
    end
    
    # Add child node.
    # Recursively adds the content of b. In case of a node-name clash, 
    # the content of this node takes precedence of whatever is in b.
    def add_child(b)
      return unless b
      a = @nodes[b.name]
      if !a
        @nodes[b.name] = b
      elsif a.kind_of?(VFSGroup)
        # Node is already present, merge children
        b.nodes.each_value do |n|
          a.add_child(n)
        end
      end
    end
    
    protected
    
    # Fetch node or create node.
    # If node is created the a new instance of the most derived class is created.
    def get_or_create_node(name, create_accessor)
      n = (self.nodes[name] ||= self.class.new(name))
      # Define method on the singleton class of ourself. I.e it affects only
      if create_accessor
        sig = class << self; self; end
        sig.class_eval do
          define_method name do |*args|
            n
          end
        end
      end
      n
    end
  end
  
end