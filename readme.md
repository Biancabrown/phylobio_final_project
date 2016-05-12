# Phylogenetic Biology - Final Project

##

# Building Phylogeny using Whole Genome Sequencing of various species from the genus drosophila.

## Introduction and Goals

Drsosophilia melanogaster is a model organism of genetics. This has led to a surge of genetic tools that are available to manipulate several species of drosophila for a wealth of different studies. There are several different instituations that caters to scientists that use these models for research. These institutions breed populations of Drosophilia which tend to have some level of polymorphism which can affect complex trait.  

The goal of my project is to answer the question?

-Investigate the phylogeny of various Drosophila species from the Drosophila Reference Planel. 

-Map gene expression characters to phylogeny tree. 

The data that is used in the project is from the DGRP lines. 

## Methods
1. Sequences were obtained from the DGRP website
2. Sequences were alighted using BowTie


```

# Request an hour of runtime:
#SBATCH --time=24:00:00

#SBATCH --nodes=1
#SBATCH --tasks-per-node=4

# Specify a job name:
#SBATCH -J MyMPIJob

# Specify an output file
#SBATCH -o MyMPIJob-%j.out
#SBATCH -e MyMPIJob-%j.out
####Bowtie Aligment

module load samtools/1.2
module load bowtie2/2.2.3
module load bcftools/1.2
module load seqtk/1.0


#begin with a folder with fastq files and the reference genome
#the reference geome should be a fasta file 

cd to folder to fastq files

bowtie2-build -f dmel-all-chromosome-r5.9.fasta.gz DM

files=(*.fq.gz)
echo ${files[@]}
mkdir SAMFILES
mkdir BAMFILES
mkdir sorted_bam
mkdir consensus
mkdir consensus_fasta

for i in "${files[@]}" 
do bowtie2 -x DM $i -S SAMFILES/$i.sam
done

for i in "${files[@]}" 
do samtools view -bS SAMFILES/$i.sam > BAMFILES/$i.bam
done

samtools faidx dmel-all-chromosome-r5.9.fasta.gz

for i in "${files[@]}" 
do samtools sort BAMFILES/$i.bam  /sorted_bam/$i 
done

for i in "${files[@]}" 
do samtools index /sorted_bam/$i.bam 
done

for i in "${files[@]}" 
do samtools mpileup -uf dmel-all-chromosome-r5.9.fasta.gz /sorted_bam/$i.bam | bcftools call -c | vcfutils.pl vcf2fq > /consensus/$i 
done

for i in "${files[@]}"
do seqtk seq -a /consensus/$i > /consensus_fasta/$i.fa
done

```

## Results

The tree in Figure 1...

## Discussion

These results indicate...

The biggest difficulty in implementing these analyses was...

If I did these analyses again, I would...

## References





