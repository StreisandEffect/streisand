try:
    # Here we monkey patch the Linode avail_kernels function
    # to always return "GRUB 2", so that we can use the
    # distribution kernel, instead of the terrible Linode one.
    import linode.api
    def avail_kernels(arg):
        return [ { 'LABEL': 'Latest 64', 'KERNELID': 210 } ]
    linode.api.Api.avail_kernels = avail_kernels
except ImportError:
    pass
