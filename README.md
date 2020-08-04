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
    > It created the image named as redis-kafka:1.1
    > then i executed this image using this command -> docker run -it redis-kafka:1.1 /bin/bash
             -> after that I have  run the command to install the package redis and kafka using some basic go command . 
                      e.g. go build -o main .

    > I have not that much idea to go , based on the logs I found osm installation was done . 
             I checked with -> ps -aux | grep 6379 (port for redis) it was present same with kafka at port 9092.


    > The things I have done in this image i.e. redis-kafka:1.1  , I saved it using docker commit 
            command -> docker commit 64f7375a203f goredis:1.1 {64f7375a203f -> container id}

    > After that using this image goredis:1.1 I have created a dockerfile to expose two ports to outside network 

           ```` FROM goredis:1.1

                WORKDIR /Users/ayush.sharma/Downloads/go-redis-kafka-demo-master
                EXPOSE 9092 6379
                
                CMD ./start.sh
           ````
    > docker build -t redis-kafka:1.2

3. After that I buildnew image  with above dockerfile and run the docker to at specific port using this command . I have shared the screenshot named as screenshot 1 with this email .



TASK 2.

   docker-compose up 
    -> Adding Screenshot named as screenshot2

TASK 3. 
   terraform.tf file is the main filr for terraform , I have not partioned the file with .tfvars file and othe resource file . It is just a main file with all variables added in the file . The app get deployed with ECS using ecs binary or helm so , I have an idea to helm so used helm as an option . after adding all the variable with the requirement . Just check the command 
       1 .terraform init 
       2. terraform plan ( to check the aws region , provider and resource )
       3. terraform apply 
