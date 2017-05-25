#! /usr/bin/perl

use strict;
use File::Compare;

my $directory = @ARGV[0];

if(not defined $directory) {
    die "Need valid directory\n";
}

my @filePaths = <STDIN>;
open(my $fh, '>', "$directory/duplicates") or die "Couldn't open file duplicates.txt, $!";
my @ignoreArray = (0);
foreach my $filePath (@filePaths) {
    
    #print "@ignoreArray\n";
    my $shouldSkip = 0;
    my $index = 0;
    while ($index < $#ignoreArray) {
        
        if($filePaths[$ignoreArray[$index]] eq $filePath) {
            $shouldSkip = 1;
            last;
        }

        $index++;
    }

    chomp($filePath);
    if($shouldSkip == 0) {
        
        if($filePath =~ m/.*\/(.+)/) {
            my $fileName = $1;
            my @duplicateArray = ();

            my $index = 0;

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
                    if($filePathToCompare ne $filePath) {
                        if($filePathToCompare =~ m/.*\/(.+)/) {
                            my $fileNameToCompare = $1;
                            if ($fileNameToCompare eq $fileName) {
                                if (compare($filePath, $filePathToCompare) == 0) {
                                    push @duplicateArray, $filePathToCompare;
                                }
                            }
                        }
                    }
                }
            }
            
            if($#duplicateArray != -1) {
                print $fh "$filePath @duplicateArray\n";
            }

            unlink @duplicateArray; #should remove files

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

#if (compare("./hello.txt", "./test/hello.txt") == 0) {}
