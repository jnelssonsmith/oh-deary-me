#! /usr/bin/perl

use strict;
use File::Copy;

my $dupesFilePath = @ARGV[0];

open(my $fh, '<', "$dupesFilePath") or die "Couldn't open file $dupesFilePath, $!";
while( my $line = <$fh>)  {   
    my @files = split(' ', $line);
    my $index = 1;
    my $originalFile = $files[0];
    while($index < $#files + 1) {
        my $currentFile = $files[$index];
        copy($originalFile, $currentFile) or die "Copy failed: $!";
        $index++;
    }
}

close $fh;
