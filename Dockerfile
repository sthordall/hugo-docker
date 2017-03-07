FROM alpine:latest

MAINTAINER Stephan Thordal <stephan@thordal.io>

ENV HUGO_VERSION 0.19
ENV HUGO_TARBALL hugo_${HUGO_VERSION}_linux-64bit.tar.gz
ENV HUGO_BINARY hugo_${HUGO_VERSION}_linux_amd64
ENV HUGO_UNTAR_DIR ${HUGO_BINARY}

# Install pygments and bash
RUN apk update \
    && apk add py-pygments \
    && apk add bash \
    && rm -rf /var/cache/apk/*

# Download/install Hugo
RUN mkdir /usr/local/hugo
ADD https://github.com/spf13/hugo/releases/download/v${HUGO_VERSION}/${HUGO_TARBALL} \
    /usr/local/hugo/
RUN tar xzf /usr/local/hugo/${HUGO_TARBALL} -C /usr/local/hugo \
    && ln -s /usr/local/hugo/${HUGO_UNTAR_DIR}/${HUGO_BINARY} /usr/local/bin/hugo \
    && rm /usr/local/hugo/${HUGO_TARBALL}

# Create workdir
RUN mkdir /usr/share/site
WORKDIR /usr/share/site

# Expose defualt Hugo port
EXPOSE 1313

# Add derived image build directory to site directory
ONBUILD ADD . /usr/share/site

# Serve site as default
ENV HUGO_BASE_URL http://localhost:1313
CMD hugo server -b ${HUGO_BASE_URL} --bind=0.0.0.0
