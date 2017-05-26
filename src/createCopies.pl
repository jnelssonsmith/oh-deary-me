#! /usr/bin/perl

use strict;
use File::Copy;

# we feed in the path to the duplicates file from command line args
my $dupesFilePath = @ARGV[0];

open(my $fh, '<', "$dupesFilePath") or die "Couldn't open file $dupesFilePath, $!";

# the dupes file is made up of lines of space seperated file paths
# where the first item in the line is the original and every other is a duplicate
while( my $line = <$fh>)  {   
    # lines are space seperated paths so we split them into a list
    my @files = split(' ', $line);
    my $index = 1;
    # first file in the line is the original
    my $originalFile = $files[0];

    # for each other file in the line we copy the original to that filepath, 
    # thus restoring the files
    while($index < $#files + 1) {
        my $currentFile = $files[$index];
        copy($originalFile, $currentFile) or die "Copy failed: $!";
        $index++;
    }
}

close $fh;
