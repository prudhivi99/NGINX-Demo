FROM golang:1.21-alpine

WORKDIR /app

COPY . .

RUN go build -o nginx-demo

EXPOSE 8080

CMD ["./nginx-demo"]