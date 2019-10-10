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
# LPUSH - RPUSH
127.0.0.1:6379> rpush lista 1
(integer) 1
127.0.0.1:6379> lpush lista 1
(integer) 2
127.0.0.1:6379> lpush lista 2
(integer) 3
127.0.0.1:6379> lpush lista 1ro
(integer) 4
127.0.0.1:6379> lrange lista 0 -1
1) "1ro"
2) "2"
3) "1"
4) "1"

# RPOP
127.0.0.1:6379> RPOP lista
"1"
127.0.0.1:6379> LPOP lista
"1ro"
127.0.0.1:6379> LRANGE lista 0 -1
1) "2"
2) "1"

# LTRIM
127.0.0.1:6379> LPUSH lista 5 4 3
(integer) 5
127.0.0.1:6379> LRANGE lista 0 -1
1) "3"
2) "4"
3) "5"
4) "2"
5) "1"
127.0.0.1:6379> LTRIM lista 0 2
OK
127.0.0.1:6379> LRANGE lista 0 -1
1) "3"
2) "4"
3) "5"

# 6


# 7
# ZADD
127.0.0.1:6379> ZADD lista_fechas 1920 a
(integer) 1
127.0.0.1:6379> ZADD lista_fechas 1922 b
(integer) 1
127.0.0.1:6379> ZADD lista_fechas 1940 c
(integer) 1
127.0.0.1:6379> ZADD lista_fechas 1930 d
(integer) 1
127.0.0.1:6379> ZADD lista_fechas 2000 e
(integer) 1

# ZRANGE
127.0.0.1:6379> ZRANGE lista_fechas 0 -1
1) "a"
2) "b"
3) "d"
4) "c"
5) "e"

# ZREVRANGE
127.0.0.1:6379> ZREVRANGE lista_fechas 0 -1
1) "e"
2) "c"
3) "d"
4) "b"
5) "a"

# WITHSCORES
127.0.0.1:6379> ZREVRANGE lista_fechas 0 -1 WITHSCORES
 1) "e"
 2) "2000"
 3) "c"
 4) "1940"
 5) "d"
 6) "1930"
 7) "b"
 8) "1922"
 9) "a"
10) "1920"

# ZRANGESCORE
127.0.0.1:6379> zrangebyscore lista_fechas -inf 1925
1) "a"
2) "b"

# zremrangebyscore
127.0.0.1:6379> zremrangebyscore lista_fechas 1920 1925
(integer) 2
127.0.0.1:6379> ZRANGE lista_fechas 0 -1
1) "d"
2) "c"
3) "e"

# ZRANK
127.0.0.1:6379> ZRANGE lista_fechas 0 -1
1) "d"
2) "c"
3) "e"
127.0.0.1:6379> ZRANK lista_fechas 'd'
(integer) 0
127.0.0.1:6379> ZRANK lista_fechas 'c'
(integer) 1

# 8
# SUBSCRIBE - PUBLISH
# Primera consola
127.0.0.1:6379> SUBSCRIBE alpha
Reading messages... (press Ctrl-C to quit)
1) "subscribe"
2) "alpha"
3) (integer) 1
1) "message"
2) "alpha"

# Segunda consola
127.0.0.1:6379> PUBLISH alpha "HELLO WORLD"
(integer) 1

# Primera consola
...
3) "HELLO WORLD"

# UNSUBSCRIBE
127.0.0.1:6379> UNSUBSCRIBE alpha
1) "unsubscribe"
2) "alpha"
3) (integer) 0

# 9
# MULTI - EXEC
127.0.0.1:6379> MULTI
OK
127.0.0.1:6379> INCR foo
QUEUED
127.0.0.1:6379> INCR bar
QUEUED
127.0.0.1:6379> EXEC
1) (integer) 1
2) (integer) 1

# 10
127.0.0.1:6379> SAVE
OK
# Incomplete

# 11
/data # redis-benchmark -q
PING_INLINE: 72833.21 requests per second
PING_BULK: 67430.88 requests per second
SET: 70771.41 requests per second
GET: 65189.05 requests per second
INCR: 71942.45 requests per second
LPUSH: 68073.52 requests per second
RPUSH: 68587.11 requests per second
LPOP: 68587.11 requests per second
RPOP: 73313.78 requests per second
SADD: 72568.94 requests per second
HSET: 74682.60 requests per second
SPOP: 72254.34 requests per second
LPUSH (needed to benchmark LRANGE): 68212.83 requests per second
LRANGE_100 (first 100 elements): 26532.24 requests per second

# 12
# Python
pip install redis

>>> import redis
>>> r = redis.Redis()
>>> r.set('py','thon')
True
>>> r.get('py')
b'thon'

# redis-cli
127.0.0.1:6379> GET py
"thon"

# Python
>>> r.set('num',1)
True
>>> r.incr('num')
2
>>> r.incr('num')
3
>>> r.get('num')
b'3'
