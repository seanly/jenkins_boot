
DOCKER_HUB=hub.digi-sky.com

.PHONY: build sync

build:
	docker build --pull -t `cat TAG`:`cat VERSION` -f Dockerfile .

sync:
	docker tag `cat TAG`:`cat VERSION` ${DOCKER_HUB}/`cat TAG`:`cat VERSION`
	docker push ${DOCKER_HUB}/`cat TAG`:`cat VERSION`

