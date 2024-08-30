#!/bin/bash
outdir="${PWD}/files/etc/greeter/html"

test -d "${outdir}" && rm -r "${outdir}"
mkdir -p "${outdir}"

cd getting_started_raw
mkdocs build
mkdir -p "${outdir}"/getting_started/
rsync -avz site/ "${outdir}"/getting_started/
cd ..

cd userguide_raw
mkdocs build
mkdir -p "${outdir}"/user_guide/
rsync -avz site/ "${outdir}"/user_guide/
cd ..

cd contributing_raw
mkdocs build
mkdir -p "${outdir}"/contributing/
rsync -avz site/ "${outdir}"/contributing/
cd ..

# copy the landing page
cp pine.png "${outdir}"/
cp landing_page.html "${outdir}"/index.html
