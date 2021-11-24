FROM golang:1.16.5 as builder
RUN mkdir /src
ADD . /src/
WORKDIR /src
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -ldflags "-s -w" -o ohmyyaml
EXPOSE 8080
ENTRYPOINT ["/src/ohmyyaml"]