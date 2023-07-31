FROM amd64/debian:bookworm

RUN echo 'deb-src http://deb.debian.org/debian bookworm main' >> /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian-security bookworm-security main' >> /etc/apt/sources.list
RUN echo 'deb-src http://deb.debian.org/debian bookworm-updates main' >> /etc/apt/sources.list
RUN apt update

RUN apt -y upgrade
RUN apt -y install vim-nox git build-essential devscripts debhelper-compat

RUN apt -y install mkdocs mkdocs-material
# RUN cargo install cargo-deb

# RUN apt -y build-dep xournalpp

RUN mkdir /root/pn_tweaks
COPY gen_deb.sh /root/pn_tweaks/

# WORKDIR /root/mutter
# CMD /root/mutter/compile.sh

ENTRYPOINT /root/pn_tweaks/gen_deb.sh
