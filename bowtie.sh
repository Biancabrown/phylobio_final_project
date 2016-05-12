#!/usr/bin/env 
####Bowtie Aligment

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