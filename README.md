Overview
========

A Python project template

Characteristics
===============

- automatic virtualenv management and requirements installation (type `make`)
- separate development and production configurations. When you type `make`, we
  will use the development settings, but a `make rpm` will use the settingss for
  deployment on production machines.
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
- add all your requierements in the `reqs.*` files
- add your code in the `sources` directory



