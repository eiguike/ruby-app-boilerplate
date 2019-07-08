#!/bin/sh

./init/wait_db.sh

echo "Starting application..."
ruby main.rb
