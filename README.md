TASK 1

1. first I have created a docker file for making my workdir and installing go modules in and adding all the files present.

     dockerfile 

          ``` FROM golang:latest

              WORKDIR /Users/ayush.sharma/Downloads/go-redis-kafka-demo-master

              COPY go.mod go.sum ./

              RUN go mod download

              COPY . . 
           ```

2. then I used this command to build docker image  -> docker build -t redis-kafka:1.1 .
    > It created the image named as dockerfile:latest
    > then i executed this image using this command -> docker run -it dockerfile:latest /bin/bash
             -> after that I have  run the command to install the package redis and kafka using some basic go command . 
                      e.g. go build -o main .

    > I have not that much idea to go , based on the logs I found osm installation was done . 
             I checked with -> ps -aux | grep 6379 (port for redis) it was present same with kafka at port 9092.


    > I things I have done in this image i.e. dockerfile:latest  , I saved it using docker commit 
            command -> docker commit 64f7375a203f goredis:1.1 {64f7375a203f -> container id}

    > After that using this image goredis:1.1 I have created a dockerfile to expose two ports to outside network 

           ```` FROM goredis:1.1

                WORKDIR /Users/ayush.sharma/Downloads/go-redis-kafka-demo-master
                EXPOSE 9092 6379
                
                CMD ./start.sh
           ````

3. After that I buildnew image  with above dockerfile and run the docker to at specific port using this command . I have shared the screenshot named as screenshot 1 with this email .



TASK 2. 

