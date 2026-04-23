---
title: Uses
draft: true
---

<!--
Scaffold. Fill each section in your own voice. Delete / rename / reorder
to taste. Once populated, flip `draft: false` and optionally submit a
PR to https://github.com/wesbos/awesome-uses to get listed at uses.tech.
-->

## Editor

I primarily use VS Code these days. For a considerable amount of time
(many years) I was a "Vimmer" and either used Vim or Neovim as my primary
text-editor/IDE. And at one point I joined the dark side and used the "Doom
Emacs" flavor of Emacs (I was seduced by org-mode... I've since seen the light,
however). At one point I purchased [Learn Vimscript the Hard
Way](https://learnvimscriptthehardway.stevelosh.com/) and wrote some rudimentary
functions in Vimscript to extend my Vim conf. Countless hours have been spent
[shaving the yak](https://en.wiktionary.org/wiki/yak_shaving) working on my
[Vim](https://github.com/kraker/dotfiles/blob/master/vim/.vimrc) and
[Neovim](https://github.com/kraker/dotfiles/tree/master/nvim/.config/nvim)
configs, as evidenced by my dotfiles.

VS Code extensions I use:

* The "Vim" extension is a must-have for "modal" editing.
* I've probably written 10s of thousands (really) lines of Ansible code by this
  point, so the Ansible and YAML extensions from Red Hat are an essential part
  of my development workflow.
* I'm old-school and my preferred Git client has always been the Git CLI. But I
  still usually install GitLens primarily for Git Blame annotations.
* A lot of my development work is IaC, so I typically have the "HashiCorp HCL" and
  "HashiCorp Terraform" extensions installed for syntax highlighting support,
  linting, etc.
* I write a lot of notes and dev-docs, and many of my personal sites are
  statically generated HTML from Markdown files. The "markdownlint" extension
  is helpful here.
* ShellCheck extension for Bash and Shell script linting support.
* Rainbow CSV for pretty and legible CSV files.
* Recently I've started playing around with Quarto for authoring book
  manuscripts, so the "Quarto" extension is installed.
* Rewrap Revived for word-wrap at 80 chars when writing docs.
* At work I'm forced to run Windows 11 using their hardware for my workstation.
  Fortunately, my development environment is usually either a RHEL server that I
  remote into with the help of the "Remote - SSH" extension or an Ubuntu WSL
  server I remote into using the "Remote - WSL" extension.
* My favorite AI assistant is Claude Code. These days the "Claude Code" extension
  is usually installed.

_This is not an exhaustive list._

## Terminal & Shell

Most of the time I'm running vanilla Bash in a VS Code terminal or whatever
terminal emulator application is the default for the OS I'm on, often with
a utilitarian "dark" theme of some kind. I try not to think about it too much.

Lately I like the [Starship cross-shell prompt](https://starship.rs/) for a
customizable shell prompt.

## Dotfiles

My public [dotfiles](https://github.com/kraker/dotfiles).

## Operating System

I tend to "dog-food" whatever Linux distro is upstream from the infrastructure
I'm managing on my personal workstation. Lately this is Fedora since it's
upstream from RHEL. In the recent past it was openSUSE Leap since that's
upstream from SLES. In the more distant past _I used Arch btw_. Most of those
days were prior to my professional career as a Linux Sysadmin back when I
enjoyed spending countless hours configuring my system outside of work. I also
like the fact that I can install Fedora from a bootable USB and install and
configure critical tools in about an hour or so.

For homelab servers I like Rocky Linux because I'm already familiar with
Enterprise Linux and I don't have to think too hard about stuff or look up
stuff I don't know. I also like Debian for its bare-bones (similar to Arch,
but less bleeding edge) and stability. It's also the base distro for Proxmox
VE, which is my preferred hypervisor that I run in my homelab.

## Hardware

<!-- Laptop, monitors, keyboard, mouse/trackpad, desk, chair,
     microphone, webcam. -->

## Sysadmin & Linux Tooling

<!-- The stuff that makes this page yours: Ansible / AAP, specific
     collections or roles you ship, SELinux tools, monitoring,
     backup, lab / test infrastructure, Obsidian (powering the Notes
     site), anything else you actually reach for on RHEL day-to-day. -->

## Productivity

* Note-taking and personal knowledge-base: [Obsidian](https://obsidian.md/)
* Email: [Purelymail](https://purelymail.com/)\
  As many custom domains and inboxes as I want for around $10/yr is hard to
  beat. Minimal, no-fuss email service provider.
* Email client:
  [Thunderbird](https://www.thunderbird.net/en-US/thunderbird/all/)

<!-- Password manager, notes app, task manager, calendar, email
     client. -->

## Browser

I mainly use Firefox.

## Reading / Staying Current

<!-- RSS feeds, podcasts, newsletters, communities. Optional — skip
     if it duplicates the DevOps Learning Resources list. -->
