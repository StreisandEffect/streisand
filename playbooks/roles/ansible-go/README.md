Go
========

Ansible role that installs [Go](https://golang.org/). The latest stable release that has been compiled for x86 64-bit Linux systems is installed by default, and different platforms and versions are supported by modifying the role variables.

Role Variables
--------------

All of these variables are optional and should only be changed if you need to install a different version of Go (e.g. if you are installing on FreeBSD, or if you need to use an earlier release).

`go_tarball`: The tarball that you want to install. A list of options can be found on the [Go Downloads page](https://golang.org/dl/). The default is the official x86 64-bit Linux tarball for the latest stable release.

`go_tarball_checksum`: This variable specifies the algorithm and checksum for the tarball that you want to install (e.g. `sha1:c7d78ba4df574b5f9a9bb5d17505f40c4d89b81c` or `sha256:a96cce8ce43a9bf9b2a4c7d470bc7ee0cb00410da815980681c8353218dcf146`). The default is the SHA256 checksum of the official x86 64-bit tarball for the latest stable release. Checksums can be found on the [Go Download Page](https://golang.org/dl/).

`go_version_target`: The string that the `go version` command is expected to return (e.g. "go version go1.2.1 linux/amd64"). This variable is used to control whether or not the Go tarball should be extracted, thereby upgrading (or downgrading) a previously installed copy. If the installed version already matches the target, the extraction step is skipped.

`go_download_location`: The full download URL. This variable simply appends the `go_tarball` variable onto the Go Download URL. This should not need to be modified.

`set_go_path`: Whether or not to set the GOPATH for all users. The default is `true`.

License
-------

The MIT License (MIT)

Copyright (c) 2013-2016 Joshua Lund

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Author Information
------------------

You can find me on [Twitter](https://twitter.com/joshualund), and on [GitHub](https://github.com/jlund/). I also occasionally blog at [MissingM](https://missingm.co).
