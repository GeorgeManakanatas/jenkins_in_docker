#!/bin/bash

while [ $# -gt 0 ] ; do
  case $1 in
    -p | --plugins) plugins="$2" ;;
    --start) start="$2" ;;
    --stop) stop="$2" ;;
  esac
  shift
done

if [[ ! -z "$start" ]]; then
    echo "starting jenkins"
    if [[ ! -z "$plugins" ]]; then
        if [[ "$plugins" = "yes" || "$plugins" = "y" || "$plugins" = "Yes" || "$plugins" = "Y" ]]; then
            echo "Running with plugins"
            docker-compose -f docker-compose-plugins.yml up
        elif [[ "$plugins" = "no" || "$plugins" = "n" || "$plugins" = "No" || "$plugins" = "N" ]]; then
            echo "Running without plugins"
            docker-compose -f docker-compose-no-plugins.yml up
        else
            echo "Wrong plugins parameter, running nothing"
            sleep 2
        fi
    else 
        echo "Missing plugins parameter, running nothing"
        sleep 2
    fi

fi

if [[ ! -z "$stop" ]]; then
    echo "stopping jenkins"
    docker-compose -f docker-compose-plugins.yml down
fi
