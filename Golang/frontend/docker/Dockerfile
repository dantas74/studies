FROM golang:1.20-alpine AS builder

WORKDIR /go/src

#COPY go.mod go.sum ./

#RUN go mod download

COPY . .

ENV CGO_ENABLED 0
ENV GOOS linux

RUN go build -o web-app -C cmd/web

FROM alpine:3.17.3

WORKDIR /app

COPY --from=builder /go/src/cmd/web/web-app .
COPY --from=builder /go/src/cmd/web/templates ./templates

EXPOSE 5000

CMD [ "/app/web-app" ]
