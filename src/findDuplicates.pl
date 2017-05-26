#! /usr/bin/perl

use strict;
use File::Compare;


# we are given a directory path from command line in which to work
my $directory = @ARGV[0];

if(not defined $directory) {
    die "Need valid directory\n";
}

# we are passed in a list of all the files in the directory from standard in
my @filePaths = <STDIN>;
open(my $fh, '>', "$directory/.duplicates") or die "Couldn't open file duplicates.txt, $!";

# we create an array here of indexes of files we do not want to check against, 
# this is useful because once we know a file has already had dupe checking, we should not check against it again
my @ignoreArray = (0);

foreach my $filePath (@filePaths) {

    
    my $shouldSkip = 0;
    my $index = 0;
    while ($index < $#ignoreArray) {
        
        if($filePaths[$ignoreArray[$index]] eq $filePath) {
            # if we find the current filepath in the ignore array then we set the should skip flag to true 
            $shouldSkip = 1;
            last;
        }

        $index++;
    }

    chomp($filePath);

    if($shouldSkip == 0) {
        
        # this regex gets the file name for us if it can be found
        if($filePath =~ m/.*\/(.+)/) {

            my $fileName = $1;
            my @duplicateArray = ();

            my $index = 0;

            # now we have to iterate over the file paths again comparing them against our current file path
            foreach my $filePathToCompare (@filePaths) {
                my $shouldSkip = 0;
                while ($index < $#ignoreArray) {
                    
                    if($filePaths[$ignoreArray[$index]] eq $filePath) {
                        $shouldSkip = 1;
                        last;
                    }

                    $index++;
                }

                if($shouldSkip == 0) {
                    chomp($filePathToCompare);
                    
                    # making sure we dont compare the exact same file twice
                    if($filePathToCompare ne $filePath) {

                        if($filePathToCompare =~ m/.*\/(.+)/) {
                            my $fileNameToCompare = $1;

                            # in dear we only care about duplicate files that have the same name
                            if ($fileNameToCompare eq $fileName) {

                                # use the built in compare function, which returns 0 when exactly the same
                                if (compare($filePath, $filePathToCompare) == 0) {
                                    push @duplicateArray, $filePathToCompare;
                                }
                            }
                        }
                    }
                }
            }
            
            if($#duplicateArray != -1) {
                # we write out the duplicate array to the file, 
                # it will have the original copy file path that we are keeing, followed by the paths of the duplicate files that we are 
                # going to remove
                print $fh "$filePath @duplicateArray\n";
            }

            # we delete all the files with file paths in the duplicate array
            unlink @duplicateArray; #should remove files

            # we now add all the files we have just processed to the ignore array so we don't check against them again
            my @removeArray = ($filePath, @duplicateArray);
            foreach my $done (@removeArray) {
                my $index = 0;
                $index++ until $filePaths[$index] eq $done;
                push @ignoreArray, $index;
            }
        }
    }
    
}

close $fh;
