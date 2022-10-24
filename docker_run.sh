#!/bin/bash


run ()
{
  docker run --rm -it \
    --mount src=`pwd`,target=/app/dnd,type=bind \
    dnd-docker \
    ls /app/dnd
}

build()
{
  docker build --tag dnd-docker .
}

$@
