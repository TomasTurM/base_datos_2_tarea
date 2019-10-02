# 1 - Install Redis with docker. 
#   Add port mapping.
#   Set up a bindmount volume.
#   Put the command used as result of this exercise.
#
# 2 - Connect to Redis and run basic commands
#   Write the command to connect using the cli
#   do a ping
#   get config values
#   etc
#
# 3 - Write examples with string
#
# 4 - Write examples with hashes
#
# 5 - Write examples with Lists
#
# 6 - Write examples with Sets
#
# 7 - Write examples with Sorted Sets
#
# 8 - Write examples using Publish Subscribe
#
# 9 - Write examples using Transactions
#
# 10 - Investigate backups
#
# 11 - Investigate Benchmarks - Run some
#
# 12 - Write a driver application (client) in Python, do some operations with it.

# 1.
docker-compose up

# Contenido docker-compose.yml
# version: '3'
# services:
#  redis:
#    image: "redis:alpine"
#    container_name: "redis_villada"
#    restart: unless-stopped
#    volumes:
#      - ./redis:/data
#    ports:
#      - 127.0.0.1:6379:6379

# 2.
# CLI
docker exec -it redis_villada sh
redis-cli
# ping
127.0.0.1:6379> ping
PONG
# config values
127.0.0.1:6379> CONFIG GET *

# 3.
# INCR
127.0.0.1:6379> SET keykey "10"
OK
127.0.0.1:6379> INCR keykey
(integer) 11
127.0.0.1:6379> GET keykey
"11"

# APPEND
127.0.0.1:6379> SET keykey "Hola"
OK
127.0.0.1:6379> GET keykey
"Hola"
127.0.0.1:6379> APPEND keykey " Mundo"
(integer) 10
127.0.0.1:6379> GET keykey
"Hola Mundo"

# GETRANGE
127.0.0.1:6379> GETRANGE keykey 0 3
"Hola"
127.0.0.1:6379> GETRANGE keykey -3 -1
"ndo"
127.0.0.1:6379> GETRANGE keykey 0 -1
"Hola Mundo"

# SETRANGE
127.0.0.1:6379> SETRANGE keykey 5 "Redis"
(integer) 10
127.0.0.1:6379> GET keykey
"Hola Redis"

# 4. 
127.0.0.1:6379> hmset user:1000 username markos birthyear 1986 verified 1
OK
127.0.0.1:6379> hgetall user:1000
1) "username"
2) "markos"
3) "birthyear"
4) "1986"
5) "verified"
6) "1"

# hincrby
127.0.0.1:6379> hincrby user:1000 birthyear 5
(integer) 1991
127.0.0.1:6379> hget user:1000 birthyear
"1991"

# 5.
