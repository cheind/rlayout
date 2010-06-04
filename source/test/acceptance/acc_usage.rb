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
    # Here's an example of packaging up a software release 
    # for some exotic product using RLayout
    
    package = RLayout.vfs_group("Exotic-#{Time.now.strftime("%Y-%m-%d")}")
    package.inc       << RLayout.lfs_glob('path/to/includes/**/*.[h,hpp]') 
    package.src       << RLayout.lfs_glob('path/to/src/*')
    package.doc       << RLayout.http_file('https://api.docs.org/latest.pdf')
    package.testdata  << RLayout.ftp_file('ftp://build.server.org/testdata.zip')
    package           << RLayout.mem_text('readme.txt', 'Exotic - Readme ... ')
    
    # No data has been read until this point.
    
    runtime = Runtime.new
    runtime.exporters << Exporters.lfs_directory('c:/temp/')
    runtime.exporters << Exporters.lfs_zipfile('c:/temp/myzip.zip')
    runtime.run(r, :dry_run => true)
  end
end