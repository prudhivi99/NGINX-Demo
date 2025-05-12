APP_NAME=nginx-demo
DOCKER_USER=prawin24
TAG=latest

all: build docker push helm

build:
	cd build && go build -o ../nginx-demo main.go

docker:
	docker build -t $(DOCKER_USER)/$(APP_NAME):$(TAG) .

push:
	echo 'Praveen#123' | docker login -u $(DOCKER_USER) --password-stdin
	docker push $(DOCKER_USER)/$(APP_NAME):$(TAG)

helm:
	helm upgrade --install myapp ./helmcharts --create-namespace --namespace myapp-ns
