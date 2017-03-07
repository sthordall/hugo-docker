# Base Hugo Docker Image
Base Docker image based on `alpine` for [Hugo](http://gohugo.io/) static sites, with a total size of just under `90 MB`.

On Docker Hub as [`sthordall/hugo`](https://hub.docker.com/r/sthordall/hugo/)

# Usage
Used as base image.

Image assumes that `Dockerfile` is in same directory as Hugo source, e.g.:

```bash
.
├── Dockerfile
├── archetypes
├── config.toml
├── content
├── data
├── layouts
├── static
└── themes
```


Images derived from the base image, can simply include:
```
FROM sthordall/hugo
```
