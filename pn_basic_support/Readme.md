# Pinenote basic support package

This is an intermediate package aimed at bundling all changes *required* for a
successful boot of the Pine64 PineNote on an otherwise pristine Debian system
(plus, a Pinenote-specific kernel package must be installed).

This package knowingly does not follow all Debian-specific packaging
guidelines. This is a direct consequence of limited time and brain resources,
and it is hoped that someone can help in transitioning to proper Debian
packages.

## Packaging

	dh_make -p pinenote-basic-support_1.0 -i --createorig
