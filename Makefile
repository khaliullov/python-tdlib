TAG := leandr/python-tdlib:3.8.0

.PHONY: all build publish

all: build

build:
	docker build -t $(TAG) .

publish:
	docker push $(TAG)
