RLayout is motivated by the fact that packaging software for distribution can be a tedious tasks. Often files from various sources need to be copied and filtered, including but not limited to documentation, binaries and source code. Additional external information needs to be downloaded such as the latest test results or the latest wording of the license agreement. Hours later, after zipping everything up, your software is ready to be released.

RLayout originates in the idea relieve the developer of performing these tasks manually. RLayout is, of course, not limited to process of the packaging of software releases.

RLayout offers the following features
  * Import from your local file system using flexible globbing expressions.
  * Import from ftp sources.
  * Import from http sources.
  * Export packages to the local file system.
  * Export packages as compressed zip files.
  * Simple extension API to provide custom importers and exporters.

## Example ##
Here is an example that shows importers and exporters work together

```
# Bundling a RLayout release.

require 'rlayout'
require 'rlayout/exporters/lfs_zipfile'

include RLayout

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
```

## Documentation ##
Either generate it from the source yourself by typing
```
rake rdoc
```
or browse it [online](http://rlayout.googlecode.com/svn/trunk/docs/index.html).

## Design Overview ##
RLayout uses importers to accumulate content from various sources. These RLayout.Importers provide information nodes (VFSNode) for RLayouts virtual file system (VFSGroup). These nodes contain information on the content and methods to read the content in chunks. Once the importing step is completed, RLayout uses exporters (RLayout.Exporters) to package the content of the virtual file system physically.

## Requirements ##
Non except Ruby. This distribution was tested on Ruby 1.8.6 and Ruby 1.9.1.

## License ##
RLayout is Copyright (c) 2010 Christoph Heindl. It is free software, and may be redistributed under the terms specified in the License file.

## Support ##
The RLayout homepage is http://code.google.com/p/rlayout/. There you will find links to report [issues](http://code.google.com/p/rlayout/issues/list) and the latest source code.
You might find additional help on the author's homepage http://cheind.wordpress.com. For general questions contact the author via email at christoph.heindl@gmail.com
