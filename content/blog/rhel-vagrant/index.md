---
title: Local Development Testing with RHEL and Vagrant
date: 2024-10-10
draft: false
---

Sometimes I need to be able to spin up a Red Hat Enterprise Linux (RHEL) server in a local development environment for testing. For many use-cases
spinning up a free [Rocky Linux](https://rockylinux.org/) image is sufficient to
test in an environment
that's a relatively close facsimile to a RHEL-proper environment. But for those
cases where you can't get around needing to test in a RHEL environment then
there's a need for a RHEL image with a subscription attached. Red Hat's 
Developer licenses are good here, with the ability to have up to 16 systems for
developer testing. More on this later...

Vagrant is really handy for spinning up servers for testing. A primer on this tool is out of the scope of this post
but if you're not familiar with it I recommend Vagrant's own [tutorials](https://developer.hashicorp.com/vagrant/tutorials) to help get you started.

I use Vagrant + VirtualBox on my Linux Workstation as a local development
environment for testing. I've found this really helpful for rapidly iterating
over things like Ansible scripts among other things. Ansible is declarative and
the idea of immutability is important when writing good code. Vagrant makes it
easy to spin up and destroy servers so that I know I'm always starting with a
system in the same state. Otherwise you could end up with some "configuration
drift" as you're developing...

## Installing prerequisites Vagrant and VirtualBox

If you haven't already, install Vagrant and VirtualBox.

* [Install Vagrant](https://developer.hashicorp.com/vagrant/install)
* [Install VirtualBox](https://www.virtualbox.org/wiki/Linux_Downloads)

> NOTE: Make sure you install the [Vagrant compatible](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox) version of VB.

## Red Hat Developer Subscription

If you don't have one already, sign up for a free Red Hat Developer Subscription:

* [Red Hat Developer Subscription for Individuals](https://developers.redhat.com/articles/renew-your-red-hat-developer-program-subscription#)

> NOTE: Make note of your username and password you used when you registered for your
account.

## Create your project

```bash
mkdir vagrant
cd vagrant
```

Initialize the project. This will create your initial `Vagrantfile`.

```bash
vagrant init
```

```bash
~/vagrant $ vagrant init
A `Vagrantfile` has been placed in this directory. You are now
ready to `vagrant up` your first virtual environment! Please read
the comments in the Vagrantfile as well as documentation on
`vagrantup.com` for more information on using Vagrant.
```

### Install vagrant-registration plugin

Install the [vagrant-registration](https://github.com/projectatomic/adb-vagrant-registration) plugin. This is a plugin that we'll use to automate
registering/deregistering our RHEL box whenever we spin it up or tear it down.

```bash
vagrant plugin install vagrant-registration
```

### Setup the vagrant-registration configuration

Edit the `Vagrantfile` you created with the following:

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # vagrant-registration plugin settings
  config.registration.username = ENV['SUB_USERNAME']
  config.registration.password = ENV['SUB_PASSWORD']

  # RHEL box...

end
```

Configure your Red Hat username and password as variables in your environment:

```bash
export SUB_USERNAME="<rhnusername>"
export SUB_PASSWORD="<rhnpassword>"
```

### Configure your RHEL box

Edit the `Vagrantfile` adding the following code after the registration block.

```ruby
...

  # RHEL 9 box
  config.vm.box = "generic/rhel9"

end
```

You're file should now look like this.

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # vagrant-registration plugin settings
  config.registration.username = ENV['SUB_USERNAME']
  config.registration.password = ENV['SUB_PASSWORD']

  # RHEL 9 box
  config.vm.box = "generic/rhel9"

end
```

### Spin up a RHEL 9 VM

Create and start your RHEL 9 VM.

```bash
vagrant up
```

![](./Screenshot%20from%202024-10-10%2021-51-11.png)

> NOTE: Vagrant automatically registers the new system with Red Hat.

SSH into the machine and verify the subscription.

```bash
vagrant ssh
```

```bash
sudo subscription-manager status
```

![](Screenshot%20from%202024-10-10%2021-58-04.png)

You can also see this server registered as an active system in your 
[Red Hat Customer Portal - Subscriptions](https://access.redhat.com/management/subscriptions/) and then by navigating to the _Systems_ tab:

![](./Screenshot%20from%202024-10-10%2022-17-45.png)

### Destroy...

You can destroy the VM when you're done testing, or as many times as you need
when testing. The vagrant-registration plugin should automatically _deregister_
your instance whenever you destroy (or _halt_, e.g. `vagrant halt`) the instance.

```bash
vagrant destroy
```

![](./Screenshot%20from%202024-10-10%2022-22-03.png)

That's it!

## Additional resources

If you're interested in taking a peek at how I use Vagrant, feel free to
puruse my [vagrant repository](https://github.com/kraker/vagrant).

### References

* [Vagrant - Docs](https://developer.hashicorp.com/vagrant/docs)
* [vagrant-registration - Docs](https://github.com/projectatomic/adb-vagrant-registration)
