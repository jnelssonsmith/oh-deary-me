#! /usr/bin/perl

use strict;
use Cwd;

my $dir = getcwd;

my $dupesFilePath = @ARGV[0];

open(my $fh, '<', "$dupesFilePath") or die "Couldn't open file $dupesFilePath, $!";
while( my $line = <$fh>)  {   
    my @files = split(' ', $line);
    my $index = 1;
    my $originalFile = $files[0];
    while($index < $#files + 1) {
        my $currentFile = $files[$index];
        system("ln -s $dir/$originalFile $currentFile");
        $index++;
    }
}

close $fh;
