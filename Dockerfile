FROM golang:alpine AS downloader
ENV BASE=https://storage.googleapis.com/kubernetes-release/release
RUN wget -q $BASE/$(wget -q -O- $BASE/stable.txt)/bin/`go env GOOS`/`go env GOARCH`/kubectl -O /usr/local/bin/kubectl && \
        chmod +x /usr/local/bin/kubectl

FROM alpine
COPY --from=downloader /usr/local/bin/kubectl /usr/local/bin/kubectl
ENTRYPOINT ["/usr/local/bin/kubectl"]
