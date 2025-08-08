---
title: Second Brain In Vim
# date: 2021-09-06 18:45
draft: true
tags:
---

In the last couple of years I've spent quite a bit of time seeking a better way
to take notes. Although a vimmer at heart I even made a foray into emacs,
org-mode, and a really nice plugin called org-roam. It's an emacs
implementation of the Roam software and I have to say it's really quite good. I
was able to have most of what I'm able to get with Vim by using the Doom emacs
configuration which allows for Vi keybindings among other things. But, I digress.

More recently I've migrated back to a vim-based work-flow but there just doesn't
seem to be quite as feature complete an implementation of everything I was able
to do in emacs org-mode with org-roam.

There's things like Vimwiki which is really popular. And there's even vim-zettel
for creating your own Zettelkasten using many of the tools that Vimwiki already
offers out of the box and adding things that are more specific to managing your
own _second brain._

I used Vimwiki + vim-zettel for a while but I was never completely happy with
it. Since I write all of my notes in Markdown I feel that the way that Vimwiki
takes over your markdown files and sets them to the `vimwiki` filetype is a bit
heavy-handed. Not to mention the Markdown syntax highlighting seems to be
lacking in implementation. It's missing things like reference links for one.
Why not let vim default or purpose built plugins like vim-markdown handle
Markdown syntax highlighting, folding, and text objects? In my opinion vim
plugins should do one thing and do it well.

## Wiki.vim

In looking for a more light-weight alternative to Vimwiki I found wiki.vim. This
plugin seems born out of the same frustrations I had. The plugin readme
addresses this very thing:

> The plugin was initially based on vimwiki, but it is written mostly from
> scratch and is based on a more "do one thing and do it well" philosophy.

It was designed to be used alongside plugins for handling whatever filetype you
prefer:

> It is designed so that it may be used along with filetype plugins, e.g. for
> dedicated Markdown plugins.

## Criteria

When looking for a solution for implementing my Zettelkasten I had the following
criteria:

* Ideally it's able to be implemented in Vim or at least something with vi
  keybindings.
* It's open source. Although Obsidian allows files to be authored in Markdown
  and it even allows vi keybindings, it's closed source software.
* I'm able to write my notes in a text-based format like org-mode or Markdown so
  that my notes are _future-proof._
  * I've settled on Markdown as my chosen syntax for authoring my notes since
    it's more widely utilized. Slack allows for a limited Markdown implementation,
    github/gitlab use it for docs, and this site was developed in Hugo which
    renders Markdown.
* I control my data. This rules out web-based solutions like Roam etc.
* I'm able to navigate between notes easily through links. Any wiki
  implementation does this
* I'm able to create unique zettel IDs
* I can easily fuzzy search through my files
* I can generate lists of back-links, broken links, and tags

## Implementation

### Alpha release

Outside of Vimwiki + vim-zettel there's a couple of other projects that are
implementations of a Zettelkasten in vim. One is
[neuron-v2](https://github.com/chiefnoah/neuron-v2.vim).  This essentially a vim
wrapper for [neuron](https://neuron.zettel.page/). Neuron is written in Haskell
and is an editor agnostic CLI utility for managing your Zettelkasten. Out of the
box neuron-v2 crashed Vim or made it so slow as to be unusable. The project
seems defunct anyways. I actually used Neuron for a while from the CLI. But this
project is being superceded by a new project that's currently in development.
It's only receiving bug-fixes from here forward. There are of course neovim
wrappers built for neuron like neuron.nvim and nerveaux.nvim, but I haven't yet
made the jump from Vim to Neovim. And because neuron is no longer actively being
developed this isn't the most future-proof solution. It's not worth the time and
effort to configure neovim with these plugins and get everything working how I
want.

### Beta release

Ok, so I've tried a few things that for one reason or another didn't work for
me. Without a suitable solution already available for Vim (or Neovim) I've
decided to cobble together a solution with things that are available in the vim
ecosystem and a little bit of vimscript in my `.vimrc` to help things along.

This is actually in the spirit of Vim and although it's a bit more of a
challenge to roll your own solution, that's really in the spirit of extensible
text editors.

It turns out that there's either features in vim or plugins that do almost
everything I would want to do to manager my personal Zettelkasten in vim.

#### Markdown

The first task is to handle markdown well. For this I installed vim-markdown and
tabular. Tabular isn't required but it's a dependency of vim-markdown if you
want to be able to fix table formatting. I used vim-plug as a plugin manager,
but you should be able to use vim's native plugin manager or the plugin manager
of your choosing to install these:

```viml
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
```

Then save your `.vimrc` and source it `:source ~/.vimrc` and then install your
plugins with:

```viml
:PlugInstall
```

Feel free to setup your tabs, indendation etc to your liking, but I have
Markdown specific handling in my `.vimrc` that looks like the following:

```viml
```

#### wiki.vim

#### Fast Searching and Linking

#### Custom Helper Functions

#### Linting and Spellcheck
