# Extensions
- Applications menu;
- Cpu power manager;
- Dash to dock;
- Disconnect wifi;
- Freon;
- Gamemode;
- Places status indicator;
- Screenshot tool;
- Sound input & output device chooser;
- System monitor;
- Unite.

# Themes
- GTK: **AdwaitaEx** (install from `themes/` folder, compatible with Nautilus 3.36+);
- Icons: **Paper**;
- Fonts: **Rubik** for UI and **JetBrains Mono** for code (from `fonts/`).

# Fractional scaling
- `gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"`

# Set primary monitor for GDM
```
# cp ~/.config/monitors.xml /var/lib/gdm/.config/
# chown gdm:gdm /var/lib/gdm/.config/monitors.xml
```
Please note that in `monitors.xml` should be no fractional-scaled displays!
Make configuration without fractional scaling, apply it to GDM and then
enable fractional scaling if necessary.

# Encrypt home directory with eCryptfs
- Use it instead of LUKS because of simpler login (no troubles with additional
  password prompts after logout/login), and auto unmount on logout;
- See `ecryptfs/README.md` for details.

# Setup Firefox
- Install `firefox/user.js` to current profile (check if everytking works okay - maybe disable webrender);
- Install `firefox/userChrome.css` to profile/chrome (after tree style tabs or sideberry installed).

# Setup PulseEffects for Logitech G560
- Install `pulseeffects`;
- Install `pulseffects/output/Logitech G560.json` to `~/.config/PulseEffects/output`;
- There should be enabled only `Loudness Compensator` with `-13db` output and `Robinson-Dadson` profile;
- Remove `speech-dispatcher` because it adds sound freezes sometimes.

# Add colorised PS1 and git support to comamnd prompt
- Install `profile.d/git.sh` -> `/etc/profile.d/git.sh` (assuming `git` is already installed).

# Firewalld
- To use NFS with libvirt/vagrant images, add `lockd` service to firewalld
  (install `firewalld/services/lockd.xml` to `/etc/firewalld/services`);
- Add `lockd` services to `libvirt` zone
  (install `firewalld/zones/libvirt.xml` to `/etc/firewalld/zones`).

# Install Bumblebee to use NVIDIA card from Wayland
- Install from here: https://copr.fedorainfracloud.org/coprs/chenxiaolong/bumblebee/
- Simply disabling nvidia-flalback.service will not work! Continue with following steps:
- - Install `/modprobe.d/nouveau-blacklist.conf`;
- - Rebuild initramfs: `dracut --force`;
- - Remove `rd.driver.blacklist=nouveau modprobe.blacklist=nouveau nvidia-drm.modeset=1`
    or something like that from kernel command-line in `/etc/default/grub`. 
- After boot you will experience black screen. To fix it, add `acpi_osi=! acpi_osi='Windows 2009'`
  to kernel command line in `/etc/default/grub`;
- Rebuild grub configuration: `grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg`.

# To enable screen on/off on fn+f2:
- Disable default key combination:
  `gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"`
- Add new command on in Control Center -> Key Combinations:
  Super+P (Screen On/Off): `/bin/sh -c "[[ $(light -G) = 0.00 ]] && light -I || (light -O; light -S 0)"`
 
# Sublime
- Install `sublime-text` and `sublime-merge` from their repo;
- Install `Package Control` and `EasyClangComplete` plugin;
- Copy configs from `sublime/` to `.config/sublime-text-3/Packages/User`.
