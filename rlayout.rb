#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'rlayout/streaming_exception'
require 'rlayout/vfs_traversal'
require 'rlayout/vfs_node'
require 'rlayout/vfs_group'
require 'rlayout/sources'
require 'rlayout/sinks'


include RLayout

n = VFSGroup.new("hugo")
n.add_child(Sources.local_file("rlayout.rb"))

ld = Sinks.LocalDirectory.new("c:/temp")
ld.generate(n)