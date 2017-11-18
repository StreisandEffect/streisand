#!/usr/bin/env python
"""
termsOfServiceLookup.py fetches the terms-of-service URL from an ACME
/directory URL. This can be used to avoid hardcoding the current
terms-of-service URL somewhere and having to update it every time
Let's Encrypt migrates to an updated ToS.

@cpu - daniel@binaryparadox.net
"""
from __future__ import print_function

import sys
import urllib2
import json


def errorPrint(*args, **kwargs):
    """
    errorPrint prints to stderr and exits the script with a non-zero status
    """
    print(*args, file=sys.stderr, **kwargs)
    sys.exit(1)


def fetchDirectory(directoryURL):
    """
    fetchDirectory returns the JSON response from an ACME /directory URL
    provided. If there is any kind of exception doing so the error is
    printed to stderr and the script terminates with a non-zero exit code.
    """
    # HTTP GET the /directory URL
    try:
        resp = urllib2.urlopen(directoryURL)
        directoryJSON = resp.read()
    except Exception as e:
        errorPrint("Unable to fetch ACME directory from '{0}': {1}"
                   .format(directoryURL, e))
    return directoryJSON


def getTOSURL(directoryJSON):
    """
    getTOSURL returns the "terms-of-service" key from the /directory JSON's
    "meta" key. If there is no "meta" key or no "terms-of-service" key then ""
    is returned. If there is any kind of exception unmarshalling the directory
    JSON the error is printed to stderr and the script terminates with
    a non-zero exit code
    """
    # Unmarshal the /directory JSON to a dict
    try:
        directory = json.loads(directoryJSON)
    except Exception as e:
        errorPrint("Unable to unmarshal ACME directory JSON: {0}"
                   .format(e))
    return directory.get("meta", {}).get("terms-of-service", "")


def getTOS(directoryURL):
    """
    getTOS prints the terms-of-service URL found in the ACME directory JSON
    located at the provided directoryURL to stdout.
    """
    print(getTOSURL(fetchDirectory(directoryURL)))


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: {0} [ACME /directory URL]".format(sys.argv[0]))
        sys.exit(1)

    getTOS(sys.argv[1])
