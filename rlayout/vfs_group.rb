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
      fetch_node(method_name.to_s, true)
    end 
    
    # Access or create nodes with otherwise invalid characters.
    def [](name)
      fetch_node(name.to_s, false)
    end
    
    # Add child node recursively.
    def add_child(b)
      a = @nodes[b.name]
      if !a
        @nodes[b.name] = b
      elsif a.instance_of?(VFSGroup)
        # Node is already present, merge children
        b.nodes.each_value do |n|
          a.add_child(n)
        end
      end
    end
    
    protected
    
    # Fetch node or create node.
    def fetch_node(name, create_method)
      n = @nodes[name] ||= VFSNode.new(name) 
      # Define method on the singleton class of ourself. I.e it affects only
      if create_method
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