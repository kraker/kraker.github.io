---
title: Learn Python Quickref
date: 2025-12-28
draft: false
---

This is my fairly opinionated quick reference on how to learn Python. This isn't
so much a guide as it is something to launch from. There are already plenty of guides. I'm writing this with the
novice in mind, but the seasoned programming veteran may derive something
useful here.

<!-- ## tl;dr

1. [Exercism - Python](https://exercism.org/tracks/python) Learn by doing Python exercies.
2. [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/) Probably the most accessible book for the novice on learning Python.
3. 
-->

## Learn by doing

Learn by doing seems to trump most other methods for learning a programming
language. This is the most bang for your buck in my humble opinion. _Minimum viable programming_ you might call it.

1. [Exercism - Python](https://exercism.org/tracks/python)
2. [Project Euler](https://projecteuler.net/)
3. [100 Days Of Code](https://www.100daysofcode.com/)

## Books on learning Python

I'm kind of old school and I'm a book learner; not everybody is though. It's worth trying different approaches until you figure out what works for you. Here are the Python books I most often recommend:

1. [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/) by Al Sweigart. _FREE_ online!
2. [Learn Python the Hard Way](https://learnpythonthehardway.org/) by Zed A. Shaw
3. [Think Python](https://allendowney.github.io/ThinkPython/) by Allen B. Downy. _FREE_ online!\
  This may be compelling to the academic; the treatment is through the lense of
  computer science.

## Video series

1. [Learn Python with Socratica](https://www.youtube.com/watch?v=bY6m6_IIN94)

## Python Development Environment

[Install Python](https://www.python.org/downloads/) for your OS.

### Python IDEs

I'm partial to VSCode for just about any type of development these days. For the novice, my advice is to learn
one general purpose code editor (not necessarioy an IDE...) like VSCode and
stick with it for a while.

1. VSCode + [Microsoft's Python](https://code.visualstudio.com/docs/languages/python) extension is probably fine to start.
2. [PyCharm](https://www.jetbrains.com/pycharm/) if you really must have a Python IDE.

### Python Interpreter

A quick note about the Python interpreter. I think this is an often overlooked
tool when first learning Python. After Python is installed you should be able
to just type `python` into a terminal and start the interpreter.

```bash
i❯ python
Python 3.13.9 (main, Oct 14 2025, 00:00:00) [GCC 15.2.1 20250808 (Red Hat 15.2.1-1)] on linux
Type "help", "copyright", "credits" or "license" for more information.
Ctrl click to launch VS Code Native REPL
i>>> message = "Hello World!"
i>>> print(message)
Hello World!
i>>> quit()
```

This comes in super handy to try stuff out interactively while you're coding.
In my opinion this is all the "IDE" you need to start with.

You can also just run scripts in the terminal using the python interpreter.

```bash
python on  main is 📦 v0.1.0 via 🐍 v3.13.9 on ☁️  (us-east-2) 
i❯ python ./main.py
Hello from python!
```

I'm a big proponent of the
[Unix as an IDE](https://blog.sanctum.geek.nz/series/unix-as-ide/) philosophy.
A little Linux CLI goes a long way; learning the Linux CLI is a bit like having
developer super powers.

## Supplementary resources

* [Python Tutor](https://pythontutor.com/) Visual Debugger and AI Tutor
* [Python Regex Tester](https://pythex.org/)
* [Awesome Python](https://github.com/vinta/awesome-python)

## General advice

I recommend picking 2-3 learning resources to use. When I'm learning a new
programming language (or other IT skill) I usually pick a combo of some kind
of _hands-on_ learning like Exercism and a solid book resource. Even when working
through a course or a book I recommend getting hands-on as quickly as possible
to reinforce the learning that's happening.
