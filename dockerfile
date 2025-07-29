FROM golang:1.22.5 AS base

WORKDIR /app

# copy go.mod which contains the dependencies
COPY go.mod .

#download dependencies
RUN go mod download

#copy source code to the docker image
COPY . .

# build the go app, we run this locally 
RUN go build -o main .

#create a new stage - final stage with destroless image

FROM gcr.io/distroless/base

# copy the binary from the base stage to default directory
COPY --from=base /app/main /app/main . 

#copy static files
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]