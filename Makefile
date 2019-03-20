IMAGENAME = navenio-docker.jfrog.io/geoserver/geoserver_2_14_2:0.2

all: build

build:
	docker build -t $(IMAGENAME) .

clean:
	docker images | awk -F' ' '{if ($$1=="$(IMAGENAME)") print $$3}' | xargs -r docker rmi

test:
	docker run --rm -t -i -p 8080:8080 -v $(IMAGENAME)
