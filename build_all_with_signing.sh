#!/usr/bin/env sh

# Pinenote Signing Key 3
export DEB_SIGN_KEYID="7B1E440180244182395EDD824153BAB1E99F1CB2"

cd pn_default_gnome_config
dpkg-buildpackage
cd ..

cd pn_tweak_libinput_touch_arbitration
dpkg-buildpackage
cd ..

cd pn_tweak_suspend_on_cover_close
dpkg-buildpackage
cd ..

cd pn_default_documents
dpkg-buildpackage
cd ..

cd pn_default_xpp_config
dpkg-buildpackage
cd ..

cd pn_handbook
dpkg-buildpackage
cd ..

# ########################################################################## #
# Move packages to release subdirectory

outdir="release_signed"
test -d "${outdir}" && rm -r "${outdir}"
mkdir "${outdir}"
mv *.deb "${outdir}"/
mv *.buildinfo *.changes "${outdir}"/
mv *.dsc "${outdir}"/
mv *.tar.xz "${outdir}"/
