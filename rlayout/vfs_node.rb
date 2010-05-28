#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

module RLayout
  
  # Node in the virtual file system
  class VFSNode
    # Sub-nodes as a hash of node name to node
    attr_reader :nodes
    # Name of node
    attr_reader :name
    
    # Initialize 
    def initialize(name)
      @name = name
      @nodes = {}
    end
    
    # Method missing event triggers creation of sub-node
    def method_missing(method_name, *args)
      fetch_node(method_name.to_s)
    end 
    
    def [](name)
      fetch_node(name.to_s)
    end
    
    def add_child(b)
      a = @nodes[b.name]
      if !a
        @nodes[b.name] = b
      else
        # Node is already present merge differences
        b.nodes.each_value do |n|
          self.add_child_node(n)
        end
      end
    end
    
    # Human readable inspection
    def inspect
      self.inspect_me(0)
    end
    
    private
    
    def fetch_node(name)
      n = @nodes[name] ||= VFSNode.new(name) 
      # Define method on the singleton class of ourself. I.e it affects only
      sig = class << self; self; end
      sig.class_eval do
        define_method name do |*args|
          n
        end
      end
      n
    end
    
    # Recurisve human readable inspection
    def inspect_me(intent)
      str = ' '*intent + "#{@name} : #{self.class}\n" 
      self.nodes.each_value do |n|
        str += n.inspect_me(intent + 2)
      end
      str
    end
  end
  
end

include RLayout
n = VFSNode.new("hugo")
n["adsad ddasdasd"].axs
r = VFSNode.new("blub")
n.add_child(r)


