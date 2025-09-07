---
title: Technical Learning
date: 2025-09-07
draft: true
author: Alex Kraker
---

# Technical Learning

I've always been interested in what I like to call _meta-learning_ or ways
that I can be a more effective learner. This goes all the way back to my
school days and I remember learning about ways that drawing mind-maps was
more effective for visual learning and that da Vinci kept notebooks, and so
I started doing that too. I started trying to capture notes in these tree-like
mind-maps. I kept moleskine notebooks for years. I also read a book on speed
reading, but I must confess even after lots of practice I was never very good
at it. Maybe I just didn't get it, but it felt like just glorified skimming to
me. But I did pick up some habits around getting a sense of the overall
structure of a book or chapter and making multiple passes at the information
each with a different purpose. For technical learning I vary rarely read
every word on the page.

## Technical learning

In terms of technical learning of skills used in software engineering, 
infrastructure engineering, cyber engineering... basically any of the <term>+
_engineering_ where the engineering being done is solving problems with
computers, there's a few techniques that I've picked up which have served me
well.

### Spaced Repetition Memory

I first learned about spaced-repetition memory when I was experimenting with
polyphasic sleeping, and the author of [supermemo](https://www.supermemo.guru/wiki/SuperMemo_Guru) has also written about this subject. But, where I first
learned about the power of using spaced-repetition memory in relation to
learning a skill like _programming_ was through this article by Derek Sivers.

[Memorizing a programming language using spaced repetition software](https://sive.rs/srs)

Spaced-repetition software (SRS), I use [Anki](https://apps.ankiweb.net/), is
a force-multiplier when learning any technical subject. It's particularly
useful when studying for certification exames, I've found.

### Type it out yourself

I can't remember where I first received this advice, but when learning something
like a programming language, type out all of the examples, exercies and labs
yourself and get it to run. There seems to be a mind-body connection and muscle
memory plays an important part in learning something like a programming language. This also forces you to slow down and really ingest and understand what you're
learning. I think the tendency is to want to just copy and paste examples from
books or tutorials into the code editor, but a lot more value is derived from typing it out manually. This is the _active_ learning required to really understand
something like a programming language in a way that sticks with you.

I always learn this way when learning something like Ansible, Terraform, Python,
etc.

Anki has a feature where you can type out the answer. I've found this really
useful for memorizing terminal commands and syntax.

### Labbing

There's no substitute for real-world hands-on experience but working out
engineering challenges in a lab environment is a decent facsimile I've found.

This is the "learn <thing> the hard way" apprach that has become a marketing
monikre for titles such as "Learn Python the Hard Way" or "Learn Kubernetes
the Hard Way". When choosing study materials I think at least one resource
should follow this apprach where the learner is encouraged to work through
the examples or labs while following along with the material. If the material
doesn't have it you should invent your own.

Creating your own homelab can be a great way to learn hands-on, but you don't
need to. Most of the time I find myself spinning up VM's in VirtualBox using
Vagrant right on my workstation. All you need is a laptop and some VM's.
For learning some topics like networking, dedicated hardware is useful though.

I highly recommend automating building lab environments with a tool like
Vagrant. There should be as little friction as possible between making a
mistake that potentially breaks your environment and being able to just
tear down and rebuild. It's important to have the psychological safety-net
to allow for experimentation, trying things, and knowing it can be easily
rebuilt. The learning process can and should be a bit messy. Very much like the
creative process. You have to break a few eggs to make an omelet sort of thing.

### Project-based learning

In my experience nothing quite solidifies technical skills I've learned
quite like working on a project using those tools. I've been fortunate in my
work that often I've had something directly related to what I was trying to
learn that I needed to build or fix. But in other cases I've learned a ton
on my own either putting together some automation for my homelab build, adding
a feature to an open source project or just building something I thought
should exist.

It's my opinion that you don't really know a thing until you've built something
with it. I stand by this.

No amount of book learning, certification exams, or _fill-in-the-blank_ is 
a substitute for being able to build something with what you've learned. In fact,
I think as soon as you can get your hands on a project to build alongside
coursework, books, or tutorials,  that's the best way to learn. It also helps
if it's something you care about. Personal projects or work projects tend to
be the best I've found.

I'll often start a project before I'm done working through whatever learning
materials I'm using for that skill. This quickly uncovers the gaps in my
learning and it forces a different kind of attention to the source material
that's necessary to solve problems. The information becomes more sticky too
as your brain starts to create a more accurate mental model of what you're
trying to learn as it makes links and associations with the hands-on
project.

Treat primary sources like books, courses, or tutorials more like references.
Project-based learning is where the real learning happens.

Don't just take my word for it either.

[Self-directed, project-based learning](https://seths.blog/2020/09/self-directed-project-based-learning/) by Seth Godin

### Take notes

I've been a religious note-taker going all the way back to my highschool days.
Note-taking seems to be a common habit among all of the really high performing
technical professionals I've encountered over the course of my career.

I don't think it matters so much _how_ you do it though, I've seen a variety
of methods used. But habitual note-taking seems to be a differentiator.

I've already written extensively on how I manage
[my personal knowledge base](https://kraker.github.io/blog/second-brain/) if
you're curious to learn more about how I do it.

### Quality primary sources

As with most things, quality matters. I also think it
pays dividends to put effort in up front in sourcing quality learning
materials. Often I'm working a full time gig while also trying to improve
my skills and advance my career. I don't have a lot of time to waste on
inferior learning materials.

I think it's well worth it to spend a little money on a book or a course if
it's well regarded. I'm a book learner, so I'll often find myself purchasing
at least 2-3 books on whatever subject I'm trying to learn. I typically base this
on researching what are the most recommended or well-regarded books on that
topic. There's usually 1-2 that are widely considered the _de facto_ standard
on some topic.

In terms of book sources I think the material should be progressive and I think
the best sources encourage the reader to follow along by doing the examples or
labs themselves.

[Ansible for DevOps](https://www.ansiblefordevops.com/) by Jeff Geerling
is one of my favorite examples that does this really well.

Another great example is [The Kubernetes Book](https://www.nigelpoulton.com/books)
by Nigel Poulton.

(These aren't affiliate links, I just really admire their work)

It's not uncommon for me to bounce between 2-3 primary sources for learning
something. I don't think the learner should rely on just one book, course,
or tutorial to learn a thing.

## tl;dr

If I had to sum up the most effective way that I learn it would be:

1. Find 2-3 well-regarded primary sources to learn from whether it's books,
  courses, or tutorials.
2. Work through the learning materials and type out the exercises, terminal
  commands, or labs manually yourself and get them to run.
3. Pick a project you're interested in to hack on and work on it alongside
  while you're learning.
4. Supplement by taking notes and doing SRS flashcards.

That's it. Have fun learning!
