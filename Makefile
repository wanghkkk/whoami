.PHONY: default check test build image

IMAGE_NAME := wanghkkk/whoami
TAG := v1

default: push

build:
	CGO_ENABLED=0 go build -a --trimpath --installsuffix cgo --ldflags="-s" -o whoami

image:
	sudo docker build -t $(IMAGE_NAME):$(TAG) .
	sudo docker tag $(IMAGE_NAME):$(TAG) $(IMAGE_NAME):latest

push:image
	sudo docker push $(IMAGE_NAME):$(TAG)
	sudo docker push $(IMAGE_NAME):latest