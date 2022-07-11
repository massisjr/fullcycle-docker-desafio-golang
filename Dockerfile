#FROM golang:1.17 AS builder

FROM rhaps1071/golang-1.14-alpine-git AS build
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -ldflags "-s -w -extldflags '-static'" -o ./hello
RUN apk add upx
RUN upx ./hello

FROM scratch
COPY --from=build /build/hello /hello
ENTRYPOINT ["/hello"]
