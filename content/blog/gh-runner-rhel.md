---
title: Self-Hosted GitHub Actions Runner on RHEL 10 with SELinux
date: 2026-05-02T20:30:29-05:00
draft: false
description:
tags:
  - 'rhel'
  - 'cicd'
  - 'github'
  - 'security'
---

Standing up a self-hosted GitHub Actions Runner on RHEL 10 as a
daemonized service.

This assumes you have a RHEL 10 server that can host a self-hosted runner. I'm
playing around with CI/CD pipelines to automate building custom RHEL images to
use for development/testing. That's my current use-case, but I'm sure there are
many reasons you might want to stand up self-hosted runners that are Red Hat
flavored. Some things in the Red Hat ecosystem are tough to do without a system
registered with Red Hat Subscription Manager.

## 1. Create github-runner system user

Security best practices want us to create a devoted system user for our service
to run as. Since this isn't a human user, we'll create a home directory in
`/opt` rather than `/home`. Also, the executables that we install to `/opt`
will inherit the `usr_t` file-context, which allows systemd to run them. More
on this later.

Create the user:

```bash
sudo useradd --system \
  --home-dir /opt/github-runner \
  --create-home \
  --shell /usr/sbin/nologin \
  --comment "GitHub Actions Runner" \
  github-runner
```

## 2. Install and configure the self-hosted runner

First switch to the _github-runner_ user and change to the home directory:

```bash
sudo -u github-runner -H bash && cd
```

{{< callout >}}
Note that we have to specify the login shell (e.g. `-H bash`) or our interactive
login won't work having set `/usr/sbin/nologin` above.
{{< /callout >}}

A quick sanity check that we're in the right directory couldn't hurt:

```bash
github-runner@hal9000:~$ pwd
/opt/github-runner
```

You can add a new runner to a repository or an organization. This is for my
personal use, so I'm adding the runner to a repository.

From a project in GitHub navigate to **Settings >> Actions >> Runners >> New
self-hosted runner** and GitHub populates a set of commands you can run to
install and configure the runner.

{{< callout type="info" >}}
See
[Adding a self-hosted runner to a
repository](https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/add-runners#adding-a-self-hosted-runner-to-a-repository)
for detailed steps to get there.
{{< /callout >}}

If you're following along, here's my install:

```bash
# Create a folder
$ mkdir actions-runner && cd actions-runner
# Download the latest runner package
$ curl -o actions-runner-linux-x64-2.334.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.334.0/actions-runner-linux-x64-2.334.0.tar.gz
# Optional: Validate the hash
$ echo "048024cd2c848eb6f14d5646d56c13a4def2ae7ee3ad12122bee960c56f3d271  actions-runner-linux-x64-2.334.0.tar.gz" | shasum -a 256 -c
# Extract the installer
$ tar xzf ./actions-runner-linux-x64-2.334.0.tar.gz
```

And your configure steps should look similar to this:

```bash
# Create the runner and start the configuration experience
$ ./config.sh --url https://github.com/kraker/homelab --token <REDACTED>
# Last step, run it!
$ ./run.sh  # Optional to skip this, since we'll set the service up next
```

The config script is interactive and will ask you for input. I just went with
the defaults, which is **ENTER** 4 times. But you may wish to override some of
them for your needs.

## 3. Install the service

Root privileges are required for these next steps so `logout` of the
_github-runner_ user. And then elevate yourself to _root_ and change to the
actions-runner directory.

```bash
sudo -i
cd /opt/github-runner/actions-runner
```

Install the service for the github-runner user, then start it:

```bash
./svc.sh install github-runner
./svc.sh start
```

### Why /opt/github-runner?

Why `/opt/github-runner` and not somewhere else like `/home` (or `/var/lib`) for
example?

A bit of behind-the-scenes on why this works: systemd is allowed to exec files
with the `usr_t` context, and our runner files all inherit `usr_t` from `/opt`.
So when `svc.sh install` generates `runsvc.sh` for us, the file is created with
`usr_t` and systemd (which runs as `init_t`) is allowed to run it. If we had
picked `/var/lib/github-runner/` instead, that same file would inherit
`var_lib_t`, which systemd isn't allowed to exec. The service would fail to
start with a "Permission denied". It would be the same problem if we had opted
for `/home/github-runner`.

One other thing worth mentioning: `svc.sh install` runs `restorecon` on the
systemd unit file itself, so we don't need to.

## 4. Verify

The service should be active and the runner connected. Status:

```bash
$ sudo systemctl status 'actions.runner.*' --no-pager
● actions.runner.<owner>-<repo>.<runner-name>.service - GitHub Actions Runner ...
     Active: active (running) since ...
   Main PID: ... (runsvc.sh)
```

And the journal will show it picked up its credentials and connected:

```bash
$ sudo journalctl -u 'actions.runner.*' -n 5 --no-pager
... runsvc.sh[...]: Started running service
... runsvc.sh[...]: √ Connected to GitHub
... runsvc.sh[...]: Listening for Jobs
```

Check your repo's **Settings >> Actions >> Runners** page in GitHub and the
runner should be sitting there with a green **Idle** badge, ready to pick up
jobs.

## References

* [Adding a self-hosted runner to a
  repository](https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/configure-the-application)
* [Configuring the self-hosted runner application as a
  service](https://docs.github.com/en/actions/how-tos/manage-runners/self-hosted-runners/configure-the-application#configuring-the-self-hosted-runner-application-as-a-service)
* [Using
  SELinux](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html-single/using_selinux/index)
