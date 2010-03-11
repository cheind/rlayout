#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

# A virtual folder that can be assigned sub-folders and files
class Node
  attr_reader :nodes
  attr_reader :file_paths
  attr_reader :name
  
  # Initialize node with name
  def initialize(name)
    @name = name
    @file_paths = []
    @nodes = {}
    self
  end
  
  # Append absolute file paths to node
  def <<(file_paths)
    case file_paths
      when Array 
        add_from_array(file_paths)
      when String
        @file_paths << file_paths
    end
    self
  end
  
  # Access or create node by name
  def [](name)
    self.send name.to_sym
  end
  
  # Invoke FileGenerator at the given destination
  def generate_at(directory_path)
    g = FileGenerator.new(self)
    g.generate(File.expand_path(directory_path))
  end
  
  private
  
  # Add from array
  def add_from_array(arr)
    arr.each do |e|
      case e
        when Node
          integrate_node(e)
        when String
          @file_paths << e
      end
    end
  end
  
  def integrate_node(b)
    a = self.nodes[b.name]
    if !a
      # Todo duplicate node?
      self.nodes[b.name] = b
    else
      merge_node_trees(a, b)
    end
  end
  
  # Merges two node trees recursively
  def merge_node_trees(a,b)
    a.file_paths.concat(b.file_paths)
    a.file_paths.uniq!
    b.nodes.each do |n, in_b|
      in_a = a.nodes[n]
      if !in_a
        a.nodes[n] = in_b
      else
        merge_node_trees(in_a, in_b)
      end
    end
  end
  
  # Each method missing event, creates
  # a node with the methods name and
  # adds an instance function with the same
  # name
  def method_missing(method_name, *args)
    n = @nodes[method_name.to_s] ||= Node.new(method_name.to_s) 
    sig = class << self; self; end
    sig.class_eval do
      define_method method_name do |*args|
        n
      end
    end
    n
  end
end



