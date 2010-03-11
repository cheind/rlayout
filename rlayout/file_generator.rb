#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

# Generates a layout to disk
class FileGenerator
  # Initialize with node
  def initialize(node)
    @node = node
    @base_path = nil
  end
  
  # Generate directory node and copy files accordingly
  def generate(directory_path)
    @base_path = File.join(directory_path, @node.name)
    generate_rec(@node, directory_path)
    self
  end
  
  # Invoke 7zip to zip up the node
  # Dirty: requires z-zip relative to this file:
  # http://railstalk.com/2009/8/6/create-a-zip-file-using-ruby
  def zip_as(file_path)
    FileUtils.rm_f(file_path) if File.file?(file_path)
    path_to_7z = File.join(File.dirname(File.expand_path(__FILE__)), '7z', '7z.exe')
    cmd = "#{path_to_7z} a -mx9 -tzip #{file_path} #{@base_path}"
    system(cmd)
  end
  
  private
  
  # Generate directory node recursively and copy files accordingly
  def generate_rec(node, parent_directory_path)
    path = File.join(parent_directory_path, node.name)
    FileUtils.rm_rf(path) if File.directory?(path)
    FileUtils.mkdir_p(path)
    node.file_paths.uniq.each do |fp|
      FileUtils.copy_file(fp, File.join(path, File.basename(fp)))
    end
    node.nodes.each_value do |l|
      generate_rec(l, path)
    end
  end
end


