#! /usr/bin/perl

use File::Compare;

if (compare("./hello.txt", "./test/hello.txt") == 0) {
	print "They're equal\n";
}
