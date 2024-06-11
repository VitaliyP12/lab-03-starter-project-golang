FROM golang:1.16 as builder
WORKDIR /app
COPY go.mod go.sum .
RUN go mod download
COPY cmd ./cmd
COPY lib ./lib
COPY templates ./templates
COPY main.go .
RUN CGO_ENABLED=0 go build -o ./myapp .
FROM gcr.io/distroless/base
COPY --from=builder /app/myapp /myapp
CMD ["./myapp", "serve"]