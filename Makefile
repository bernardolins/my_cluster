TAG?=master
ELIXIR_VERSION?=latest
IMAGE_NAME?=bernardolins/mycluster

build-image:
	docker build --build-arg APP_TAG=${TAG} --build-arg ELIXIR_VERSION=${ELIXIR_VERSION} -t ${IMAGE_NAME}:${TAG}-elixir_${ELIXIR_VERSION} .
