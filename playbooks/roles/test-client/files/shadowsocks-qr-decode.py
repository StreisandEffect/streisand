#!/usr/bin/python2
#
# shadowsocks-qr-decode.py
#
# This script accepts a path to a QR code image as an input. If the QR code
# contains an encoded `ss://` URL for the Shadowsocks protocol[0]
# then it is processed and the constituent parts (method, password, server
# address, etc) are output to stdout.
# This allows other tools (e.g. a test script) to configure itself based on a QR
# code from a Shadowsocks server.
#
# This script requires `zbar-tools` be installed from apt. You might ask
# yourself "Why not use the `qrtools` Python package?" The answer is that
# getting a 3rd party Python dep requires `pip` be installed and we have no
# other reasons to use it. More importantly, it turns out `qrtools` uses the
# same lib underneath:`zbar`.
#
# TODO(@cpu) - update for python3 compatibility. The `urlparse` module was
#              moved.

import urlparse, sys, base64, re, argparse
from subprocess import check_output

parser = argparse.ArgumentParser(description="Process a Shadowsocks QR Code")
parser.add_argument('file', help="path to a Shadowsocks QR code image")
parser.add_argument("--cipher", help="output ciphername",
                    action="store_true")
parser.add_argument("--password", help="output password",
                    action="store_true")
parser.add_argument("--server", help="output server",
                    action="store_true")
parser.add_argument("--port", help="output port",
                    action="store_true")
args = parser.parse_args()

cmd = ["zbarimg", args.file]
try:
    urlData = check_output(cmd)
    # Strip the leading "QR-Code:" that `zbarimg` adds
    if urlData.startswith("QR-Code:"):
        urlData = urlData.replace("QR-Code:", "")
except:
    print("Error running '{0}'\n".format(" ".join(cmd)))

try:
    parts = urlparse.urlparse(urlData)
except:
    print("Unable to parse decoded image data '{0}' as URL\n".format(urlData))
    sys.exit(1)

if parts.scheme != "ss":
    print("URL had scheme {0}, which isn't 'ss' and is unsupported\n".format(parts.scheme))
    sys.exit(1)

encodedData = parts.netloc

try:
    shadowsocksURL = base64.b64decode(encodedData)
except:
    print("Unable to base64 decode encoded netloc '{0}'\n".format(encodedData))
    sys.exit(1)

# First capture group: cipher
# Second capture group: password
# Third capture group: server address
# Fourth capture group: server port
shadowsocksURLRegexStr = r'^([\w\-]+):([\w+=\/]+)@([\w\-\.]+):([\d]+)$'
shadowsocksURLRegex = re.compile(shadowsocksURLRegexStr)

match = shadowsocksURLRegex.match(shadowsocksURL)

if match:
    cipher = match.group(1)
    password = match.group(2)
    server = match.group(3)
    port = match.group(4)

    if args.cipher:
        print(cipher)
    elif args.password:
        print(password)
    elif args.server:
        print(server)
    elif args.port:
        print(port)
    else:
        print("cipher: {0}".format(cipher))
        print("password: {0}".format(password))
        print("server: {0}".format(server))
        print("port: {0}".format(port))
else:
    print("Decoded Shadowsocks URL '{0}' did not match regex.\n".format(shadowsocksURL))
    sys.exit(1)
