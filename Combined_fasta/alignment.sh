#!/bin/bash

# Request an hour of runtime:
#SBATCH --time=24:00:00

#SBATCH --nodes=1
#SBATCH --tasks-per-node=8

# Specify a job name:
#SBATCH -J MyMPIJob

# Specify an output file
#SBATCH -o MyMPIJob-%j.out
#SBATCH -e MyMPIJob-%j.out

# Run a command

 mafft Chr2L_10mb_combined.fasta>Chr2L_10mb_aligned.fasta 
 mafft Chr2L_1mb_combined.fasta>Chr2L_1mb_aligned.fasta 
 mafft Chr2L_20mb_combined.fasta>Chr2L_20mb_aligned.fasta 
 mafft Chr2R_10mb_combined.fasta>Chr2R_10mb_aligned.fasta 
 mafft Chr2R_1mb_combined.fasta>Chr2R_1mb_aligned.fasta 
 mafft Chr2R_20mb_combined.fasta>Chr2R_20mb_aligned.fasta 
 mafft ChrX_10mb_combined.fasta>ChrX_10mb_aligned.fasta 
 mafft ChrX_1mb_combined.fasta>ChrX_1mb_aligned.fasta 
 mafft ChrX_20mb_combined.fasta>ChrX_20mb_aligned.fasta 