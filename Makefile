VERSION = $(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)


format:
	gofmt -s -w ./

build: format
	go build -v -o ./ffbot -ldflags "-X="github.com/bohdanSolovicky/FFbot/cmd.appVersion=$(VERSION)