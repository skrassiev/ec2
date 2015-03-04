#!/bin/sh

curl -sSL https://bootstrap.pypa.io/get-pip.py | python
pip install docker-py
pip install --user --upgrade git+git://github.com/signalfuse/maestro-ng
