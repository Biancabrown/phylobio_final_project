#!/usr/bin/perl -w
use strict;

my $i = 0;
my $cmd = "";

my @chrom = ('ChrX');

for ($a = 0; $a < @chrom; $a++) {

  my @AllFiles = ();
  my @FasFiles = ();

  #open directory
  opendir DIR, "/Users/Binky/desktop/fasta/pool_sequences/pool_ChrX_sequences" or die "couldn't open directory\n";
  @AllFiles = readdir(DIR);
  closedir DIR;
  
  #find correct input files
  for ($i = 0; $i < @AllFiles; $i++){
    if ($AllFiles[$i] =~ m"$chrom[$a]"){
      push (@FasFiles, (split '.seq', $AllFiles[$i])[0]);
    }
  }
  
  #add header to each file
  for ($i = 0; $i < @FasFiles; $i++){
    $cmd = qq(awk 'BEGIN{print "\>$chrom[$a]"}1' ) . $FasFiles[$i] . ".seq > " . $FasFiles[$i] . ".fasta";
    system($cmd);
  }
}
