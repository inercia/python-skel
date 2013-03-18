Overview
========

A Python project template

[![Build Status](https://travis-ci.org/inercia/python-skel.png?branch=master)](https://travis-ci.org/inercia/python-skel)

Characteristics
===============

- automatic virtualenv management and requirements installation (type `make`)
- separate development and production configurations. When you type `make`, we
  will use the development build process (`buildout.devel.cfg`), but a `make rpm`
  will use the build (`buildout.deploy.cfg`) for deployment on production machines.
- project cleanup (type `make distclean`)
- automatic Sphinx documentation (type `make docs` or `make docs-pdf` on the
  project root directory). It will discover any packages in the `sources` and add
  the corresponding files in the `docs/api` directory...
- complete RPM packaging of the virtualenv, including the Python interpreter and
  all the installed libs (just type `make rpm`, and a nice rpm will appear the
  the top directory). This packaging method allows you to install any additional
  software in the virtualenv (ie, `nginx`) and it will be nicely packaged in
  the RPM...
- optional `redis` build and installation (inside the virtualenv)
- basic `fabric` file, based on a config file (`fabfile.cfg`), for doing things
  like deploying RPMs, starting/stopping services, cleaning up logs on the
  remote machines, etc.

Usage
=====

- search for all the occurrences of XXXX and replace them by your project name
- search for all the XXXX* files and rename them accordingly
- customize anything you want on the `buildout*` scripts
- add your code in the `sources` directory


FAQ
===

Can I change the Python version?
--------------------------------

Set a different version on the `Makefile` with the `SYS_PYTHON` variable

How do you package things in the rpm?
-------------------------------------

The rpm is built by creating a virtualenv and installing all the eggs with the
virtualenv's easy_install. Any other artifact created by a compatible recipe
(ie, recipes that use the `output` attribute)

Can I put some other stuff in the rpm?
---------------------------------------

Yes, just set the right `output` attribute in your recipe.

How can I enable the redis build?
---------------------------------

Add the `redis-build` and `redis-config` parts to the buildout.cfg/parts



