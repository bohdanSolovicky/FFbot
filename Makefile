APP = ffbot#$(shell basename $(shell git remote get-url origin))
USER = felixfelicisua
VERSION = $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETARCH = arm64 #$(shell dpkg --print-architecture)
TARGETOS = linux

linux:
	make build TARGETOS=linux TARGETARCH=$(TARGETARCH)

macos:
	make build TARGETOS=darwin TARGETARCH=$(TARGETARCH)

windows:
	make build TARGETOS=windows TARGETARCH=$(TARGETARCH)

format:
	gofmt -s -w ./

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o ./ffbot -ldflags "-X="github.com/bohdanSolovicky/FFbot/cmd.appVersion=$(VERSION)

image:
	docker build . -t $(USER)/$(APP):$(VERSION)-$(TARGETARCH) --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}

push:
	docker push $(USER)/$(APP):$(VERSION)-$(TARGETARCH)

clean:
	rm -rf ffbot