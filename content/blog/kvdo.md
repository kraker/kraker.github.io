---
title: RHEL 9 kmod-kvdo bug
date: 2025-08-02
draft: false
---

The kmod-kvdo module is used to enable VDO in kernel usespace. On RHEL it's primarily used to thin provision logical volumes with LVM. See the links below.

## Useful links

* Upstream open source [dmo-vdo/kvdo][1] project.
* RHEL 9 [Introduction to VDO on LVM][2]

[1]: https://github.com/dm-vdo/kvdo
[2]: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/deduplicating_and_compressing_logical_volumes_on_rhel/proc_providing-feedback-on-red-hat-documentation_deduplicating-and-compressing-logical-volumes-on-rhel

## Install & enable kvdo

Install kmod-kvdo:

```bash
dnf install -y kmod-kvdo
```

Enable kernel module kvdo with:

```bash
modprobe -v kvdo
```

Under normal conditions, this works to install and enable the kvdo module for RHEL, but as I've shown below, it's broken for RHEL 9.6.

## RHEL 9.6 kmod-kvdo bug

There was a bug opened that was closed as resolved for enabling kvdo for the RHEL 9.6 kernel:

* <https://issues.redhat.com/browse/RHEL-61201>

But, I've found this bug is still unresolved in the latest version of RHEL 9.6.

I tried opening a new bug, but I don't have access to the RHEL project in Jira, so I opened a developer feedback ticket:

* <https://issues.redhat.com/browse/RHDFEED-1283>

Hopefully this get's to the right place!

According to the [Red Hat Bugzilla - Migrated Products](https://bugzilla.redhat.com/page.cgi?id=redhat/migrated_products.html) page I'm supposed to be able to submit bug reports for RHEL 7/8/9 in Jira now. Do I need to submit a bug report about not being able to submit bug reports? If any Red Hat engineers happen upon this, let me know!

### Steps to reproduce

1. Install or update to RHEL 9.6

```bash
dnf update -y
```

Verify RHEL release and kernel release. A reboot may be necessary to load the latest kernel.

```bash
[root@rhel9b ~]# cat /etc/redhat-release 
Red Hat Enterprise Linux release 9.6 (Plow)
```

The system should be on the latest kernel release, 5.14.0-570.30.1.el9_6, as of this writing.

```bash
[root@rhel9b ~]# uname -r
5.14.0-570.30.1.el9_6.x86_64
```

3. Install kmod-kvdo which provides the kvdo kernel module

```bash
dnf install -y kmod-kvdo
```

Note the version of kmod-kvdo that's installed:

```bash
[root@rhel9b ~]# rpm -q kmod-kvdo
kmod-kvdo-8.2.5.10-161.el9.x86_64
```

5. Attempt to enable the kvdo kernel module:

```bash
[root@rhel9b ~]# modprobe kvdo
modprobe: FATAL: Module kvdo not found in directory /lib/modules/5.14.0-570.30.1.el9_6.x86_64
```

#### Additional notes

One interesting thing I noticed while troubleshooting is that the kmod-kvdo package appears to have been compiled against the 5.14.0-568 kernel release:

```bash
[root@rhel9b ~]# rpm -ql kmod-kvdo
/etc/depmod.d/kvdo.conf
/lib/modules/5.14.0-568.el9.x86_64
/lib/modules/5.14.0-568.el9.x86_64/extra
/lib/modules/5.14.0-568.el9.x86_64/extra/kmod-kvdo
/lib/modules/5.14.0-568.el9.x86_64/extra/kmod-kvdo/vdo
/lib/modules/5.14.0-568.el9.x86_64/extra/kmod-kvdo/vdo/kvdo.ko
```

Note the `/lib/modules/` path.

This doesn't match the installed kernel:

```bash
[root@rhel9b ~]# rpm -q kernel-core
kernel-core-5.14.0-362.8.1.el9_3.x86_64
kernel-core-5.14.0-570.30.1.el9_6.x86_64
[root@rhel9b ~]# uname -r
5.14.0-570.30.1.el9_6.x86_64
```

In fact, there doesn't appear to be a 5.14.0-568 kernel release available in the base repositories:

```bash
[root@rhel9b ~]# dnf repoquery kernel-core-5.14.0-568*
Updating Subscription Management repositories.

This system has release set to 9.6 and it receives updates only for this release.

Last metadata expiration check: 0:40:22 ago on Sun 03 Aug 2025 03:48:53 AM UTC.
[root@rhel9b ~]# 
```

### Workaround - build from source

Building from source seems to be a viable workaround until the Red Hat engineers have had a chance to fix the bug or an update to a newer release with the bug fixed becomes available.

1. Fetch the latest source tar ball from the [dm-vdo/kvdo/release](https://github.com/dm-vdo/kvdo/releases).

```bash
wget https://github.com/dm-vdo/kvdo/archive/refs/tags/8.2.6.5.tar.gz
```

2. Untar the tarball

```bash
[root@rhel9b ~]# tar xf 8.2.6.5.tar.gz 
```

3. Compile and install

```bash
cd kvdo-8.2.6.5/
```

make

```bash
make -C /usr/src/kernels/`uname -r` M=`pwd`
```

Install

```bash
make -C /usr/src/kernels/`uname -r` M=`pwd` modules_install
```

4. Enable kernel module

```bash
modprobe kvdo
```

Verify that it's enabled:

```bash
[root@rhel9b kvdo-8.2.6.5]# lsmod | grep ^kvdo
kvdo                  860160  0
```

5. (Optional) Enable kvdo persistently across reboots

```bash
echo kvdo > /etc/modules-load.d/kvdo.conf
```
