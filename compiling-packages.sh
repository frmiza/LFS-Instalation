#!/bin/bash

#binutils gcc
for package in linux glibc; do
  source packages-install.sh 5 $package
done

