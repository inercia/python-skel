Overview
========

This is just a quick start guide, describing the main things you can do with this code.
If you want deeper details, you should build the documentation...


Characteristics
===============

- automatic virtualenv management and requirements installation (type `make`)
- project cleanup (type `make distclean`)
- automatic Sphinx documentation (type `make docs` or `make docs-pdf` on the
  project root directory)
- complete RPM packaging of the virtualenv, including the Python interpreter and
  all the installed libs (just type `make rpm`, and a nice rpm will appear the
  the top directory)
- basic `fabric` file, based on a config file (`fabfile.cfg`), for doing things
  like deploying RPMs, starting/stopping services, cleaning up logs on the
  remote machines, etc.
- optional `redis` build and installation (inside the virtualenv)

Usage
=====

- search for all the occurrences of XXXX and replace them by your project name
- search for all the XXXX* files and rename them accordingly
- customize anything you want on the `buildout*` scripts
- add all your requierements in the `reqs.*` files
- add your code in the `sources` directory



