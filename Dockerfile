FROM golang:1.24.3-alpine

WORKDIR /app

COPY build/go.mod .
#COPY build/go.sum .      # optional, if it exists
RUN go mod download

COPY build/main.go .

RUN go build -o nginx-demo

EXPOSE 8080

CMD ["./nginx-demo"]

