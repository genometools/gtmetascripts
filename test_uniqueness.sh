#!/bin/sh -e

. uniqueness.sh

if is_unique
then
  echo "is unique"
  while true
  do
    sleep 5
  done
else
  echo "not unique"
fi
