FROM alpine:latest

RUN apk add --no-cache texlive-full
RUN apk add --no-cache pandoc py3-pygments fontconfig biber

RUN adduser -D tex
USER tex
