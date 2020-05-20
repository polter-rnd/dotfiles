# eCryptfs support

Unfortunately the automatic unmounting is susceptible to [break](https://bbs.archlinux.org/viewtopic.php?id=194509) with systemd and bugs are filed against it. See the following resources:

- https://bugs.freedesktop.org/show_bug.cgi?id=72759
- https://nwrickert2.wordpress.com/2013/12/16/systemd-user-manager-ecryptfs-and-opensuse-13-1/
- https://bugs.launchpad.net/ubuntu/+source/ecryptfs-utils/+bug/313812/comments/43
- http://lists.alioth.debian.org/pipermail/pkg-systemd-maintainers/2014-October/004088.html

## Solution

If automatic unmounting of eCryptfs on logout does not work (as, for example, on Fedora by default), you have to install this service file to `/usr/lib/systemd/user/` and enable it:

```
$ sudo systemctl --user enable ecryptfs-autounmount # (for current user only)
$ sudo systemctl --global enable ecryptfs-autounmount # (for all users)
```

If using SELinux this could be not enough however. In this case you have to catch all errors via `audit2allow` with `semodule -BD` at first. Do not forget to turn it off later via `semodule -B`. The working pocily is provided in file `ecryptfs-autounmount.te`, but it could be redundant, so better review it before use. Steps to insert it:

```
$ checkmodule -M -m -o ecryptfs-autounmount.mod ecryptfs-autounmount.te
$ semodule_package -o ecryptfs-autounmount.pp -m ecryptfs-autounmount.mo
$ sudo semodule -i ecryptfs-autounmount.pp
```

## Warning
Is authselect tool is used for managing authentication, do not edit `/etc/pam.d/*` files by hand. Check if `with-ecryptfs` feature is enabled.

