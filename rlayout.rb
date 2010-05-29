#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'rlayout/streaming_exception'
require 'rlayout/vfs_traversal'
require 'rlayout/vfs_node'
require 'rlayout/vfs_group'
require 'rlayout/importers'
require 'rlayout/exporters'

include RLayout

n = VFSGroup.new("hugo")
r = Importers.lfs_file("rlayout.rb")
n.add_child(r)
puts n.inspect

Exporters.lfs_directory(n, "c:/temp", :delete_if_existing => true)

