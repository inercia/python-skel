Overview
========

This is just a quick start guide, describing the main things you can do with this code.
If you want deeper details, you should build the documentation...


Characteristics
===============

- automatic requirements installation: type `make`
- complete RPM packaging of the virtualenv, including the Python interpreter and
  all the installed libs: just type `make rpm`, and a nice rpm will appear the
  the top directory...
- automatic Sphinx documentation: type `make docs` or `make docs-pdf` on the
  project root directory
- optional `redis` build and installation (inside the virtualenv)

Usage
=====

- search for all the occurrences of XXXX and replace them by your project name
- customize anything you want on the `buildout*` scripts
- add all your requierements in the `reqs.*` files
- add your code in the `sources` directory



