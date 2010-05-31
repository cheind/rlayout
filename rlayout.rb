
require 'rlayout/exceptions'
require 'rlayout/vfs_traversal'
require 'rlayout/vfs_node'
require 'rlayout/vfs_streamable_node'
require 'rlayout/vfs_group'
require 'rlayout/node_naming'
require 'rlayout/runtime'
require 'rlayout/importers'
require 'rlayout/exporters'


# Main module of RLayout
module RLayout
  # Home of Exporters.
  # Exporters are entities transforming virtual file system
  # to file systems and other end-points.
  module Exporters
  end

  # Home of Importers.
  # Importers generate nodes for the virtual file system that
  # are capable of reading content from various sources.
  module Importers
  end
end