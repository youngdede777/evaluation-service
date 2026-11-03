# --- Etapa 1: build ---
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux go build -o evaluation-service .

# --- Etapa 2: imagem final ---
FROM alpine:3.19
RUN apk add --no-cache ca-certificates
WORKDIR /app
COPY --from=builder /app/evaluation-service .
EXPOSE 8004
ENTRYPOINT ["./evaluation-service"]
