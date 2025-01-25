#!/usr/bin/env sh

cd pn_basic_support
dpkg-buildpackage -us -uc
cd ..

cd pn_custom_repo_and_keyring
dpkg-buildpackage -us -uc
cd ..

cd pn_default_gnome_config
dpkg-buildpackage -us -uc
cd ..

cd pn_tweak_libinput_touch_arbitration
dpkg-buildpackage -us -uc
cd ..

cd pn_tweak_suspend_on_cover_close
dpkg-buildpackage -us -uc
cd ..

cd pn_default_documents
dpkg-buildpackage -us -uc
cd ..

cd pn_default_xpp_config
dpkg-buildpackage -us -uc
cd ..

# ########################################################################## #
# Move packages to release subdirectory

test -d release && rm -r release
mkdir release
mv *.deb release/
mv *.buildinfo *.changes release/
mv *.dsc release/
mv *.tar.xz release/
