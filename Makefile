NAME := socat-static
OUTPUT_DIR := output
IMAGE := jetstackexperimental/socat-static

image:
	docker build -t $(IMAGE):temp .

build:
	# create a container
	$(eval CONTAINER_ID := $(shell docker create \
		${IMAGE}:temp \
	))

	# run build inside container
	docker start -a $(CONTAINER_ID)

	# copy artifacts over
	rm -rf $(OUTPUT_DIR)/
	docker cp $(CONTAINER_ID):/$(OUTPUT_DIR) .

	# remove container
	docker rm $(CONTAINER_ID)

clean:
	rm -rf $(OUTPUT_DIR)/
