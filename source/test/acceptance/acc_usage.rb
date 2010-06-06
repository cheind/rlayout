#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'
require 'rlayout/exporters/lfs_zipfile'
include RLayout

class TestAcceptanceUsage < Test::Unit::TestCase
    
  def test_usage
    # Here's an example of bundling a RLayout release.
    
    package = RLayout.vfs_group("RLayout-#{Time.now.strftime("%Y-%m-%d")}")
    package.lib       << Importers.lfs_glob('rlayout/**/*.rb')
    package.etc       << Importers.http_file('http://rlayout.googlecode.com/svn/trunk/source/License')
    package.etc.data  << Importers.ftp_file('ftp://build.server.org/testdata.zip')
    package           << Importers.mem_text('readme', 'RLayout - Release ... ')
    package           << Importers.os_exec('changelog', 
                                           'svn log', 
                                           :args => ['http://rlayout.googlecode.com/svn/trunk'])

    # No data has been read until this point.
    
    runtime = Runtime.new
    runtime.exporters << Exporters.lfs_directory('c:/temp/')
    runtime.exporters << Exporters.lfs_zipfile('c:/temp/myzip.zip')
    runtime.run(package, :dry_run => false)
  end
end