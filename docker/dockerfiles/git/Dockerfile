# Git Server

MAINTAINER jcmdln

FROM alpine:latest
RUN apk update -y && apk upgrade -y
RUN apk install go
RUN go get github.com/gogits/gogs
RUN cd $GOPATH/src/github.com/gogits.com/gogs && go build && ./gogs web

# Gogs will need to be downloaded from source
