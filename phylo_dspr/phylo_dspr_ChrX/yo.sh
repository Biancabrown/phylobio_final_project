#!/bin/bash

# INPUT
# Example ./yo.sh Chr2L.EA3_Chr2L.seq.fasta EA3_Chr2L.fasta
seqID=$1 # input sequence ID
inFA=$2 # input fasta

# check if the dir output exists
if [ ! -d output ]; then
    mkdir output
fi

# create the chrom size file. SHOULD ONLY RUN ONCE
echo -e "$seqID\t26000000" > chrom.size
# make a BED file for that. SHOULD ONLY RUN ONCE
bedtools makewindows -g chrom.size -w 1000000 > 1mb.bed
# Extract sequences. REPLACE INPUT.fa and OUTPUT.fa with your file names.
bedtools getfasta -fi $inFA -bed 1mb.bed -fo ./output/out.fasta

cd output
../split_fa.bash < out.fasta
rm out.fasta
cd ..

rm chrom.size 1mb.bed

#Run Example
#./yo.sh Chr2L.EA3_Chr2L.seq.fasta EA3_Chr2L.fasta
