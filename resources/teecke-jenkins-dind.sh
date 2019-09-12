#!/bin/bash -e

# Start docker in the background
/usr/local/bin/dockerd-entrypoint.sh &

# Enable the docker daemon for jenkins user access
while [ ! -S /var/run/docker.sock ]
do
  sleep 2
done
chmod 666 /var/run/docker.sock

# Start jenkins in the background
sudo -E -u jenkins bash -c "/sbin/tini -- /usr/local/bin/jenkins.sh $@" &

# Container main proccess. Allow docker & jenkins processes to be restarted
tail -f /dev/null
