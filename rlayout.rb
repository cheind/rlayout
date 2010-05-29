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

=begin
include RLayout

n = VFSGroup.new("hugo")
r = Sources.local_file("rlayout.rb")
n.add_child(r)
puts n.inspect

ld = Sinks::LocalDirectory.new("c:/temp", :delete_if_existing => true)
ld.generate(r)
=end