#!/bin/bash

branch=$1
file=$2
git cat-file -p $(git cat-file -p ${branch}^{tree} | grep "${file}" | cut -d" " -f3 | cut -b -40)

