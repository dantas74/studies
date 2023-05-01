FROM golang:1.20-alpine AS builder

WORKDIR /go/src

COPY go.mod go.sum ./

RUN go mod download

COPY . .

ENV CGO_ENABLED 0
ENV GOOS linux

RUN go build -o auth-app

FROM alpine:3.17.3

WORKDIR /app

COPY --from=builder /go/src/auth-app .

EXPOSE 80

CMD [ "/app/auth-app" ]
