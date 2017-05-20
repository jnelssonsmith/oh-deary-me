#!/bin/bash

rm -rf testEnv
rm -f duplicates.txt
mkdir testEnv
cp -R testBackup/* testEnv
find testEnv | ./findDuplicates.pl