FROM goredis:1.1

WORKDIR /Users/ayush.sharma/Downloads/go-redis-kafka-demo-master
EXPOSE 9092 6379

CMD ./start.sh





