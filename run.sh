#!/bin/bash

while true; do
  curl -ksIL -X GET -H 'Host: example.com' https://<ip address>
  # TODO: add 
  # curl -ksIL -X GET -H 'Host: example.com' https://<ip address>
  # for each site
done

# TODO
# chmod +x ./run.sh
# ./run.sh
