#!/usr/bin/env python

import sys
from distutils.version import StrictVersion

if len(sys.argv) != 3:
    print("Usage: version_at_least minimum_version version_to_check")
    sys.exit(1)

minimum_version = StrictVersion(sys.argv[1].strip())
version_to_check = StrictVersion(sys.argv[2].strip())

if version_to_check >= minimum_version:
    sys.exit(0)
else:
    sys.exit(1)
