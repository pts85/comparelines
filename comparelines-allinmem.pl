#!/usr/bin/perl
# Reads all rows from FILE1 and FILE2 to memory ("hashmap") and compares them 
# Beware that big files eat huge amounts of memory

use strict;
use warnings;
$|++;

if ($#ARGV <1) {
        print ": Give me parameters: two filenames\n: eg. $0 file1 file2\n";
        exit 2;
}

open (FILE1,$ARGV[0]) or die "FILE1 error";
open (FILE2,$ARGV[1]) or die "FILE2 error";

my $misscount=0;
my $tmpline;

print ": Reading files to memory...\n";

my %hash1;
while ($tmpline=<FILE1>) {
	$hash1{$tmpline}=undef;
}
$tmpline="";

my %hash2;
while ($tmpline=<FILE2>) {
	$hash2{$tmpline}=undef;
}
$tmpline="";


my @counts=(scalar keys %hash1, scalar keys %hash2, 0);
$counts[2]=$counts[0]-$counts[1];
print ": $counts[0]|$counts[1] rows, diff=$counts[2]\n";

for (keys %hash1) {
	if (not exists $hash2{$_}) {
		print $_;
		$misscount++;
	}
}

print ": $misscount missing rows in FILE2 (diff was $counts[2]) \n";
if ($counts[2] != $misscount) {
	print": (There might be rows in FILE2 that are not in FILE1)\n";
}

close(FILE1);
close(FILE2);
exit 0;
