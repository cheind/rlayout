#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
include RLayout

class TestAcceptanceRuntime < Test::Unit::TestCase
    
  def test
    r = RLayout.vfs_group('release')
    r.a << Importers.lfs_glob('rlayout/**/e*.rb')
    
    runtime = Runtime.new
    runtime.exporters << Exporters.lfs_directory('c:/temp/', :dry_run => true)
    runtime.run(r)
  end
end