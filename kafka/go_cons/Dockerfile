FROM golang:1.19-alpine AS builder

WORKDIR /app

ENV http_proxy=http://192.168.20.28:8080
ENV https_proxy=http://192.168.20.28:8080

COPY go_cons/go.mod go_cons/go.sum ./
RUN go mod download

COPY go_cons/. .

RUN go build -o kafka-consumer .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/kafka-consumer .

CMD ["./kafka-consumer"]

