#!/bin/bash

if [ -z "$HOME" ]
then
  echo "\$HOME not set."
  exit
fi

m use 4.4.4-ent --config ./mongod.conf --configExpand "exec"

