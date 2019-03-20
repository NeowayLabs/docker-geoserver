IMAGENAME = navenio-docker.jfrog.io/geoserver/geoserver_2_14:${TAG}

build:
	docker build -t $(IMAGENAME) .

clean:
	docker images | awk -F' ' '{if ($$1=="$(IMAGENAME)") print $$3}' | xargs -r docker rmi

test:
	docker run --rm -t -i -p 8080:8080 $(IMAGENAME)

test_volume:
	docker run --rm -t -i -p 8080:8080 -v ${LOCAL_DATA_DIR}:/geoserver_data/data $(IMAGENAME)

push:
	docker push $(IMAGENAME)