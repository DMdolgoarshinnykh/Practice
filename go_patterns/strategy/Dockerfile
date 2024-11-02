FROM golang:1.21 as builder

ENV http_proxy=http://192.168.20.28:8080
ENV https_proxy=http://192.168.20.28:8080

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

FROM alpine:latest  

ENV http_proxy=http://192.168.20.28:8080
ENV https_proxy=http://192.168.20.28:8080

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/main .

CMD ["./main"]
