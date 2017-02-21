#!/bin/bash

set -e

if [ -f /app/tmp/pids/server.pid ]; then
  rm -f /app/tmp/pids/server.pid
fi

#we use exec on the last line to make sure
#that rails will be run as pid 1 (i.e. no extra shell)
#and thus get the signals to stop.
exec bundle exec "$@"
