#!/bin/sh

# Deploy hook that runs after a successful certbot renewal (not each attempt)

# Reload nginx to gracefully shut down old worker processes and serve the new cert.
systemctl reload nginx
