# Variables
IMAGE_NAME=prawin24/nginx-demo
TAG=latest
NAMESPACE=myapp-ns
APP_NAME=nginx-demo

# Build and Docker Image
build:
	CGO_ENABLED=0 GOOS=linux go build -o main ./build/main.go

docker:
	docker build -t $(IMAGE_NAME):$(TAG) .
	docker login -u "prawin24" -p "Praveen#123"
	docker push $(IMAGE_NAME):$(TAG)

# TLS Certificate and Secret
tls:
	mkdir -p tls
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout tls/tls.key -out tls/tls.crt \
		-subj "/CN=example.com/O=example.com"
	kubectl create secret tls nginx-tls-secret \
		--cert=tls/tls.crt --key=tls/tls.key -n $(NAMESPACE) || true

# Create ConfigMap for nginx.conf
configmap:
	kubectl create configmap nginx-config \
		--from-file=nginx/nginx.conf -n $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -

# Helm install/upgrade
deploy:
	helm upgrade --install $(APP_NAME) ./helmcharts -n $(NAMESPACE) --create-namespace

all: build docker tls configmap deploy
