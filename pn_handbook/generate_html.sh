#!/bin/bash
outdir="${PWD}/files/etc/greeter/html"

test -d "${outdir}" && rm -r "${outdir}"
mkdir -p "${outdir}"

cd userguide_raw
mkdocs build
mkdir -p "${outdir}"/user_guide/
rsync -avz site/ "${outdir}"/user_guide/
cd ..

# copy the landing page
cp landing_page.html "${outdir}"/index.html
