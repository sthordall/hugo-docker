FROM alpine:latest

MAINTAINER Stephan Thordal <stephan@thordal.io>

ENV HUGO_VERSION 0.19
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux-64bit

# Install pygments and bash
RUN apk update \
    && apk add py-pygments \
    && apk add bash \
    && rm -rf /var/cache/apk/*

# Download/install Hugo
RUN mkdir /usr/local/hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tgz \
    /usr/local/hugo/
RUN tar xzf /usr/local/hugo/${HUGO_BINARY}.tgz -C /usr/local/hugo/ \
    && ln -s /usr/local/hugo/hugo /usr/local/bin/hugo \
    && rm /usr/local/hugo/${HUGO_BINARY}.tgz

# Create workdir
RUN mkdir /usr/share/site
WORKDIR /usr/share/site

# Expose defualt Hugo port
EXPOSE 1313

# Automagically build site
ONBUILD ADD . /usr/share/site

# Serve site as default
ENV HUGO_BASE_URL http://localhost:1313
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0
