TAG?=master
ELIXIR_VERSION?=latest
IMAGE_NAME?=bernardolins/mycluster
CONTAINER_NAME?=mycluster
KUBERNETES_MANIFEST_FILE=mycluster.yaml

build-image:
	docker build --no-cache --build-arg APP_TAG=${TAG} --build-arg ELIXIR_VERSION=${ELIXIR_VERSION} -t ${IMAGE_NAME}:${TAG}-elixir_${ELIXIR_VERSION} .

publish:
	docker push ${IMAGE_NAME}:${IMAGE_VERSION}

run_local:
	docker run --name ${CONTAINER_NAME} -d -p 4000:4000 ${IMAGE_NAME}:${IMAGE_VERSION}

kill:
	docker stop mycluster
	docker rm mycluster

kubernetes_deploy:
	kubectl apply -f mycluster.yaml

pods:
	kubectl get pods

svcs:
	kubectl get services
