FROM debian:testing-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN useradd tex

# Block all -doc packages
RUN printf "Package: texlive-doc-*\nPin: release *\nPin-Priority: -1\n" \
    > /etc/apt/preferences.d/no-texlive-doc

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    latexmk \
    biber \
 && apt-cache depends texlive-full | grep "Depends: " | grep -v -- "-doc" | sed 's/Depends: //' | xargs apt-get install -y --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/*

USER tex
