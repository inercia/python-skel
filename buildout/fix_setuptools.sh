#!/bin/sh

TOP=$1

echo ">>> removing old setuptools"
rm -rf lib/python*/site-packages/setuptools*

echo ">>> installing clean setuptools"
$TOP/bin/python  $TOP/buildout/ez_setup.py -U setuptools


