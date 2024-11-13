#!/bin/bash

# Install Redis
apt-get install lsb-release curl gpg
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
chmod 644 /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
apt-get update
apt-get -y install redis

# Configure Redis
echo "bind * -::*" >> /etc/redis/redis.conf
echo "requirepass ${redis_password}" >> /etc/redis/redis.conf

# Restart Redis server
/etc/init.d/redis-server restart