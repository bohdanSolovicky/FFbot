APP = ffbot#$(shell basename $(shell git remote get-url origin))
USER = felixfelicisua
VERSION = $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
OS = linux
ARCH = arm64 #$(shell dpkg --print-architecture)

format:
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=$(OS) GOARCH=$(ARCH) go build -v -o ./ffbot -ldflags "-X="github.com/bohdanSolovicky/FFbot/cmd.appVersion=$(VERSION)

image:
	docker build . -t $(USER)/$(APP):$(VERSION)-$(ARCH)

push:
	docker push $(USER)/$(APP):$(VERSION)-$(ARCH)

clean:
	rm -rf ffbot