# Builder stage
FROM golang:1.24.3-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

COPY migrations ./migrations
COPY templates ./templates

RUN go build -o /app/main ./cmd/app/main.go

# Final lightweight image
FROM alpine:latest

WORKDIR /app


COPY --from=builder /app/main .
COPY --from=builder /app/migrations ./migrations
COPY --from=builder /app/templates ./templates

EXPOSE 8080

CMD ["./main"]