#!/bin/bash
rm -r testOut*
./dear -g testOut testBackup/
./dear -b testOut testBackup/
./dear -c testOut testBackup/
./dear testOut testBackup/
