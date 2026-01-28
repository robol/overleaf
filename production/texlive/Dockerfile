FROM debian:testing

RUN apt-get update
RUN apt-get install -y --no-install-recommends texlive-full
RUN apt-get install -y --no-install-recommends fontconfig inkscape pandoc python3-pygments

RUN useradd tex
USER tex
