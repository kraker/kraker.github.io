---
title: On Learning Ansible
date: 2023-11-08
draft: false
---

![](jonathan-chng-Ch8S4zHDQfE-unsplash.jpg)
Photo by [Jonathan Chng](https://unsplash.com/@jon_chng?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash) on [Unsplash](https://unsplash.com/photos/white-metal-frame-glass-roof-Ch8S4zHDQfE?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash)

I recently had someone reach out to me on LinkedIn asking if I would mentor them
on Ansible. Like many sysadmins I know I'm short on bandwidth and regretfully
had to decline. But I did offer a [book recommendation](#1-book-ansible-for-devops) 
and a link to the [Ansible Discord](#4-ansible-discord) I sometimes frequent...

But this was enough to inspire me to write up some of my thoughts on learning
Ansible.

## 0. Prerequisites

### Learn Linux

In coaching a former colleague on Ansible who is a Windows Sysadmin I
learned that it's hard to wrap your head around Ansible if you don't already
know some Linux. You don't need to become a Linux Sysadmin to learn Ansible,
but the learning curve might be too steep if you aren't at least proficient in
the Linux CLI. Because Ansible runs on Linux to be able to learn it you tend to
spend a lot of time in the Linux CLI running Ansible commands and trying things.

Learning the Linux CLI is out of the scope of this guide, but there are already
a lot of great resources available for learning the basics. Here are some that I
typically like to recommend:

* [Learning the Shell](https://linuxcommand.org/lc3_learning_the_shell.php)
* [Command Line Crash Course](https://forum.learncodethehardway.com/t/appendix-a-command-line-crash-course/768)
* From MIT's "Missing Semester" course: 
  + [The Shell](https://missing.csail.mit.edu/2020/course-shell/)
  + [Command-line Environment](https://missing.csail.mit.edu/2020/command-line/)

If you aren't already at least somewhat proficient in the Linux CLI go learn
that first, then circle back to Ansible when you're ready.

### Learn some scripting

Whether it's Bash, PowerShell, Python, or some other scripting language, having
some scripting under your belt is really helpful for being able to wrap your
head around Ansible.

Talking in terms of Bash. The Linux CLI is to Bash scripting what Bash scripting
is to Ansible. Ansible is a couple layers of abstraction removed from running 
basic commands in the CLI.

Like climbing a ladder, it's probably easier if you don't try to skip the first
few rungs. After you've wrapped your head around scripting, Ansible starts to
make a lot more sense. You can skip learning scripting, but I wouldn't necessarily
recommend it.

Here's my go-to recommendation for learning both the Linux CLI and scripting in Bash:

* [The Linux Command Line](https://linuxcommand.org/tlcl.php) by William Shotts\
  You can download the book for free! But I recommend supporting the author by
  buying a copy if you can.

And if you're a Windows Sysadmin who's learning Ansible, it probably makes sense
to learn PowerShell instead of Bash, but me being a Linux Sysadmin,
unfortunately I don't have something I have tried myself that I can recommend.
I have heard some good things about
[Learn PowerShell in a Month of Lunches](https://www.manning.com/books/learn-powershell-in-a-month-of-lunches).

## 1. Book: "Ansible for DevOps"

[Ansible for DevOps](https://www.ansiblefordevops.com/) by Jeff Geerling is the
best resource that I've found for learning Ansible. I highly recommend picking
up a copy of this book and working through it. I recommend typing out all of the
commands and code and running it. This is really all you should need to get
started.

Jeff Geerling's
[Ansible 101](https://www.youtube.com/playlist?list=PL2_OBreMn7FqZkvMYt6ATmgC0KAGGJNAN)
series on YouTube is also quite good as a supplement to his book as it covers
a lot of the same material.

## 2. Video: "Getting started with Ansible"

If you prefer video over book learning, Learn Linux TV's 
[Getting started with Ansible](https://www.youtube.com/playlist?list=PLT98CRl2KxKEUHie1m24-wkyHpEsa4Y70)
is also a solid recommendation. I'm a big fan of this channel for interesting
tech videos and tutorials about Linux in general.

## 3. Learn by Doing

Most of the sysadmins I know are the "learn by doing" type and I'm no exception.
My Ansible learning journey started this way because I needed to write some
Ansible for work and I sort of just jumped right in and did it by writing
some playbooks. This isn't a bad way to get started and you can learn a lot by
trying to make something useful right away.

The official [Getting started with Ansible](https://docs.ansible.com/ansible/latest/getting_started/index.html)
is a good entry point if choose to go this route.

In general I've found the official [Ansible Documentation](https://docs.ansible.com/ansible/latest/index.html)
to be well-written with lots of helpful examples.

## 4. Ansible Discord

As a supplement to your learning, it's helpful to know where you can go to ask
questions if you get stuck. I sometimes frequent the
[Ansible Discord](http://www.catb.org/~esr/faqs/smart-questions.html) and I've
been known to answer questions here and there when I need a break from
working. (Yes, I enjoy Ansible enough that fielding questions about it in
Discord is an enjoyable distraction for me... ;-)

I recommend asking questions
[the smart way](http://www.catb.org/~esr/faqs/smart-questions.html) for best
results.

## Conclusion

That's all there really is too it. It's hard to improve upon "Ansible for
DevOps" as a learning resource and this is really probably my best recommendation
for learning Ansible. Other than that, most of my Ansible skills I've acquired
by building things with it. Some recommendations for acquiring some of the more
advanced Ansible skills and other tips and tricks I've picked up along the way
is probably a good topic for a future article, so stay tuned for a "part 2."
