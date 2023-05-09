VERSION = $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
OS = linux
ARCH = $(shell uname -m)

format:
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=$(OS) GOARCH=$(ARCH) go build -v -o ./ffbot -ldflags "-X="github.com/bohdanSolovicky/FFbot/cmd.appVersion=$(VERSION)

clean:
	rm -rf ffbot