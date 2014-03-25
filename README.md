

1. Install pip
2. sudo pip install dopy

TODO: 
- Document other dependencies, including initial Ansible setup
- Set up server reboot and playbook to watch for its return. This will ensure all of the latest software is running after setup completes.
- Final confirmation prompt explaining the ~/streisand directory and providing further instructions
- Ensure that none of the software (e.g. Shadowsocks and OpenVPN) are configured to log IP addresses
- Stunnel setup for an alternate OpenVPN connection method running on port 993 that defeats DPI



1. Create a DigitalOcean account (if you don't already have one)
2. Go to the API section of the DigitalOcean Control Panel
3. Click "Create" to generate your API key (if it doesn't already exist)


# Possible help text for Shadowsocks (taken from my original standalone role)
A custom QR code that can be used to automatically configure your Shadowsocks clients has been downloaded to /tmp/shadowsocks-qr-code/ss.png. Simply scan this image to get up and running quickly. Look for the option when creating a new profile in the iOS and Android applications.


Features
--------
* OpenVPN with DNS resolution handled via Dnsmasq
* Shadowsocks
* Tor
* Obfsproxy
