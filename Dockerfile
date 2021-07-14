FROM golang:1.16.6-alpine AS build
RUN apk add --no-cache ca-certificates
WORKDIR /src
COPY . .
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o standardnotes-extension-server cmd/standardnotes-extension-server/main.go

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /src/standardnotes-extension-server /
COPY --from=build /src/definitions /definitions
ENV SN_EXTS_LISTEN_ADDR :80
ENV SN_EXTS_UPDATE_INTERVAL_MINS 4320
ENV SN_EXTS_REPOS_DIR /repos
ENV SN_EXTS_DEFINITIONS_DIR /definitions
ENTRYPOINT ["/standardnotes-extension-server"]
