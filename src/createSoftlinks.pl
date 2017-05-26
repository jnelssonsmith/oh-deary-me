#! /usr/bin/perl

use strict;
use Cwd;
use File::Spec;
use File::Basename;

my $dir = getcwd;

my $dupesFilePath = @ARGV[0];

open(my $fh, '<', "$dupesFilePath") or die "Couldn't open file $dupesFilePath, $!";
while( my $line = <$fh>)  {   
    my @files = split(' ', $line);
    my $index = 1;
    my $originalFile = $files[0];
    while($index < $#files + 1) {
        my $currentFile = $files[$index];
        
        my $dirname = dirname("$dir/$currentFile");
        chdir($dirname) or die "$!";
        
        my $rel_path = File::Spec->abs2rel( "$dir/$originalFile", "$dirname");
        my $name = fileparse("$dir/$currentFile");
        
        system("ln -s $rel_path $name");
        $index++;
    }
}

close $fh;
