== FIT3042 ASSIGNMENT 3 ==
Name: Josh Nelsson-Smith
SID: 25954113

== INSTALLATION ==
This folder includes the dear and undear files for running, they also make use 
of the perl scripts in the src/ directory. 
The scripts make use of common compression algorithms, however not all linux distros 
come with compress installed, so if this is the case for you, you can install using:
$ sudo apt-get install ncompress 
or similar. 
To run dear and undear you need to ensure they have correct execute permissions using 
chmod +x or similar. 

== ABOUT == 
Dear is a deduping archiver, it stores records of all duplicates in a directory with the
same name and removes them when archiving using a variety of compression methods. 
Undear reverses the output of dear, and allows for a variety of different ways of dealing with the 
duplicates (removing them, replacing them, creating soft links for them)

The way in which my implementation of dear and undear handles duplicates is contained within 
the logic of the findDuplicates.pl perl script, I find any duplicates for a given file and 
store them in a .duplicates file. Once the copies have been listed in .duplicates, I remove them so 
we can reduce space of the directory. Undear then looks for and reads from the .duplicates file and 
replaces the files as the user has chosen. Finally we remove the .duplicates file and the directory is 
restored.

== RUNNING == 
Dear takes the form:
dear [option] outfile indir
where the available options are:
-g compress reslt using gzip
-b compress result using bzip2 
-c compress result using compress
note that if a flag is not provided, dear will simply tar the file. 

so an example running of it would be:
$ ./dear -g myGzippedFile myNotYetGzippedFile
which would create a gzipped file with name myGzippedFile.tar.gz

Undear takes the form:
undear flag indir
Note that the flag is now required, which take the options:
-d delete duplicates
-l recreate duplicates as soft links to the original
-c recreate duplicates as copies of the original


== TESTS ==
For convenience I have included a test script that runs all the different combinations of 
flag for dear and undear and then checks the output against another prepared file that 
has been created manually. 

You can run the test via:
$ ./test

and clean up the test via:
$ ./clean

== LIMITATIONS == 
The program has not been tested for installation (adding dear and undear to your path), so there is not 
promise that it will work when not accessed by literal path. 
The program uses relative symlinks for the undear -l feature, meaning that you can move unarchived 
directory around, but moving the symlinked file will break it. I chose this over 
absolute symlinking because I feel it is more likely a user will move around an unarchived directory 
rather than the files specifically within it. RAM has noted that both have their drawbacks and both 
are acceptable for this assignment though. 
