#!/bin/bash

shopt -s nullglob

cd /artifacts
for d in */ 
do
  echo "Adding artifacts directory: $d"
  mkdir -p /appsdata/projects/$d
  cp /artifacts/$d*.* /appsdata/projects/$d 
done

for d in /appsdata/projects/*/ 
do
  cd "$d"
  pwd
  for z in *.zip 
  do
   echo "unzipping file: $z"
   unzip "$z"
   rm -f "$z" 
  done
done

