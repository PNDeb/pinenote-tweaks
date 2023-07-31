#!/bin/bash

cd handbook_raw
mkdocs build
rsync -avz site/ ../files/etc/greeter/html/
