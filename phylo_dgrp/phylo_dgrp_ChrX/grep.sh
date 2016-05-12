#!/bin/bash
 
grep '>' *.fasta > tmp  
while read EachFa
do
   arrIN=(${EachFa//:>/ })
   fa=${arrIN[0]}
   seqID=${arrIN[1]}
   echo "running ./yo.sh $seqID $fa"
   ./yo.sh $seqID $fa
done < tmp
rm tmp