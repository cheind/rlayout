
module RLayout
  
  # A grouping node for child nodes.
  #
  # A group node is either complete or incomplete. Complete group nodes
  # contain all child nodes explicitely. Incomplete group nodes contain
  # possibly 'rolled-up' child nodes that will be unrolled when generating
  # the output.
  #
  # Since Runtime implements a single read/multiple write architecture that
  # aims at reducing the number of required reads, you should use dynamically
  # generated child nodes when access to the layout cannot be defined without
  # possibly long lasting reads.
  # 
  class VFSGroup < VFSNode
    # Sub-nodes as a hash of VFSNode#name to VFSNode
    attr_reader :nodes
    
    # Initialize with name
    def initialize(name)
      super(name)
      @nodes = {}
      @is_complete = true
    end
    
    # Method missing event triggers creation of sub-node
    def method_missing(method_name, *args)
      get_or_create_node(method_name.to_s, true)
    end 
    
    # Access or create nodes with otherwise invalid characters.
    def [](name)
      get_or_create_node(name.to_s, false)
    end
    
    # Add child nodes.
    def add_children(nodes)
      case nodes
        when Array then nodes.each {|n| add_child(n)}
        when VFSNode then add_child(nodes)
      end
    end
    alias :<< :add_children
    
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
    
    # True if node is complete, false otherwise
    def complete?
      @is_complete
    end
    
    # True if node is incomplete, false otherwise
    def incomplete?
      !complete?
    end
    
    # Dynamically expand rolled-up child nodes
    #
    # A VFSGroup can either be complete or incomplete. A term that refers
    # to the state of its child nodes. If complete, all child nodes are present, 
    # some child nodes are dynamically created while traversing the virtual file system.
    #
    # Use unroll to return an Array of dynamically generated child nodes. Explicit existing
    # child nodes take precedence over dynamically unrolled nodes. It is possible
    # to merge dynamically generated nodes with the explicit children (use add_children). In
    # that case you should change the nodes state to complete.
    #
    def unroll
      nil
    end
    
    protected
    
    # Mark node as incomplete
    def incomplete!
      @is_complete = false
    end
    
    # Fetch node or create node.
    # If node is created the a new instance of the most derived class is created.
    def get_or_create_node(name, create_accessor)
      n = (@nodes[name] ||= self.class.new(name))
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
  
  # Instance a new virtual file system group
  def RLayout.vfs_group(name)
    VFSGroup.new(name)
  end
  
end