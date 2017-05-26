#! /usr/bin/perl

use strict;
use Cwd;
use File::Spec;
use File::Basename;

# to create relative symlinks we need to know the full paths first, so 
# need cwd to do that accurately
my $dir = getcwd;

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
    while($index < $#files + 1) {
        my $currentFile = $files[$index];
        
        # to create the symlink correctly we need to cd into the directory in which we 
        # wish to create the link
        my $dirname = dirname("$dir/$currentFile");
        chdir($dirname) or die "$!";
        
        # we create a relative path linking where we want to place the softlink, 
        # to the file we are softlinking to
        my $rel_path = File::Spec->abs2rel( "$dir/$originalFile", "$dirname");

        # softlink will have same filename
        my $name = fileparse("$dir/$currentFile");
        
        # then we perform the link
        system("ln -s $rel_path $name");
        $index++;
    }
}

close $fh;

