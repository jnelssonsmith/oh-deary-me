#!/bin/bash
rm -r testOut*
echo "== TESTING G FLAG FOR DEAR (GZIP) =="
./dear -g testGzip testBackup/
echo "== TESTING G FLAG FOR DEAR (BZIP2) =="
./dear -b testBzip testBackup/
echo "== TESTING G FLAG FOR DEAR (COMPRESS) =="
./dear -c testCompress testBackup/
echo "== TESTING G FLAG FOR DEAR (TARFILE) =="
./dear testTar testBackup/

echo "== TESTING NO FLAG FOR UNDEAR (GZIP) =="
./undear -t testGzip.tar.gz
echo "== TESTING NO FLAG FOR UNDEAR (BZIP2) =="
./undear -t testBzip.tar.bz2
echo "== TESTING NO FLAG FOR UNDEAR (COMPRESS) =="
./undear -t testCompress.tar.Z
echo "== TESTING NO FLAG FOR UNDEAR (TARFILE) =="
./undear -t testTar.tar