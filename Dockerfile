FROM golang:1.22-alpine AS builder
WORKDIR /app
FROM alpine:3.10.3
COPY --from=builder /app .
WORKDIR /app
COPY main.go .
ENV GO111MODULE auto
COPY --from=builder /usr/local/go/ /usr/local/go/
ENV PATH="/usr/local/go/bin:${PATH}"
RUN  go mod init main && \
     go mod tidy && \
     go build -o app
CMD ["/app/app"]
