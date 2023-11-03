awk -v OFS='\t' '{print $1,1,$2}' hg38.chrom.sizes > chroms.bed
awk -v OFS='\t' '{print $1,$2,$3,$4}'  merge.bed > merget.bed
sort -k1,1 -k2,2n chroms.bed -o chroms.bed
sort -k1,1 -k2,2n merget.bed -o merget.bed
bedtools intersect -a chroms.bed -b merget.bed -wb -sorted > mergef.txt
awk '{print $1,$2,$3,$7}' mergef.txt > mergef.bed

awk -v OFS='\t' '{print $1,1,$2}' hg38.chrom.sizes > chroms.bed

awk -v OFS='\t' '{print $1,$2,$3,$4}'  merge.bed > merget.bed

sort -k1,1 -k2,2n chroms.bed -o chroms.bed
sort -k1,1 -k2,2n merget.bed -o merget.bed
bedtools intersect -a chroms.bed -b merget.bed -wb -sorted > mergef.txt
awk '{print $1,$2,$3,$7}' mergef.txt > mergef.bed



for f in *.meth
do
 echo $f
 head $f -n29152485 > "${f%.*}".m
done

for f in *.m
do
 echo $f
 awk '{print $1,$2,$2+1,$5}' $f | /labs/mpsnyder/moqri/soft/ucsc/wigToBigWig /dev/stdin /labs/mpsnyder/moqri/soft/ucsc/hg38.chrom.sizes "${f%.*}".bw
done

    awk '{print $1,$2,$2+1,$5}' $f.meth | /labs/mpsnyder/moqri/soft/ucsc/wigToBigWig /dev/stdin /labs/mpsnyder/moqri/soft/ucsc/hg38.chrom.sizes $f.bw


