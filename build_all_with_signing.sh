#!/usr/bin/env sh

# Pinenote Signing KEy 2
export DEB_SIGN_KEYID="DD1D0D77F26513424CEE6987276D8785BD77E98A"

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
