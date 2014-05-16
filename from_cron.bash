#!/bin/env bash


set -o pipefail  # trace ERR through pipes
set -o errtrace  # trace ERR through 'time command' and other functions
set -o nounset   ## set -u : exit the script if you try to use an uninitialised variable
set -o errexit   ## set -e : exit the script if any statement returns a non-true return value

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # http://stackoverflow.com/questions/59895
cd $DIR

DATE=$(date +%Y-%m-%dT%H:%M)

git pull
python2.7 generate/crawl_collections.py
git commit -a -m "auto $DATE"
git push
