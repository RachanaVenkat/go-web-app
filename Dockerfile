FROM golang:1.22.5 as base 
# can use ubuntu or anything as a base image as well but need to install go on install go on it 

WORKDIR /app

COPY go.mod . 
# cuz the dependencies for the app are stored here

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
