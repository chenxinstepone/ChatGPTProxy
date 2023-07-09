FROM golang:alpine AS builder
WORKDIR /app
COPY . .
RUN go build -ldflags="-w -s" -o v4proxy main.go

FROM alpine
WORKDIR /app
COPY --from=builder /app/v4proxy .
RUN apk add --no-cache tzdata
ENV TZ=Asia/Shanghai
EXPOSE 9090
CMD ["/app/v4proxy"]
