FROM golang:1.25-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /parcels .
FROM alpine:latest
WORKDIR /app
COPY --from=builder /parcels /app/parcels
COPY --from=builder /app/tracker.db /app/tracker.db
CMD ["/app/parcels"]
