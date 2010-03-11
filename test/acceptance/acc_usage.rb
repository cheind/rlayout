#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'
require 'rlayout'

class TestAcceptanceLayout < Test::Unit::TestCase
    
  def test_usage
    release = Node.new("rlayout_release")
    release.rlayout << glob("rlayout/**/*.rb", :sub_nodes => true)
    release << ["License", "README"]
    
    p release.rlayout
    
  end
end