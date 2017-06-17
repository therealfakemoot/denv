# Git Server

MAINTAINER jcmdln

FROM alpine:latest

ARG gogs_pass

RUN apk update -y && apk upgrade -y

# Postgresql
RUN apk update -y && apk upgrade -y && apk add --update postgresql
RUN psql -c "create user gogs;"
RUN psql -c "alter user gogs with password '${gogs_pass}';"
RUN psql -c "create database gogs;"
RUN psql -c "grant all priveleges on gogs to gogs;"


# Gogs 
RUN apk update -y && apk upgrade -y && apk add --update go wget \
&& go get github.com/gogits/gogs \
&& cd $GOPATH/src/github.com/gogits.com/gogs && go build \
&& mkdir -p ./custom/conf/
ADD app.ini $GOPATH/src/github.com/gogits.com/gogs/custom/conf/app.ini
RUN ./gogs web
