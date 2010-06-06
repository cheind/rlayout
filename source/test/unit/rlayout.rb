#
# (c) Christoph Heindl, 2010
# http://cheind.wordpress.com
#

require 'test/unit'

# Read node and assert the number of blocks received and final string read.
def assert_read_node(node, assert_nblocks, assert_string, chunksize = 1024)
  count = 0
  read_str = ''
  node.read_stream(chunksize) do |bytes|
    read_str += bytes
    count += 1
  end
  assert_equal(assert_nblocks, count)
  assert_equal(assert_string, read_str)
end