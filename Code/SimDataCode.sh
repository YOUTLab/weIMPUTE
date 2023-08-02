#!/bin/bash


n1=1
n2=100


k=$RANDOM$RANDOM
for i in $(seq $n1 1 $n2);do
  nohup ./ped-sim -d 1fam.def -m refined_mf_hg38_noCHR.simmap --intf sex_av_nu_p_hg38_campbell_noCHR.tsv -i data.vcf -o out/1fam_err"$i" --err_rate 0 --seed "$k" &
done


for i in $(seq $n1 1 $n2);do
  nohup /bcftools-1.8/bcftools sort out/1fam_err"$i".vcf -O z -o out/fam_err"$i".vcf.gz &
done

for i in $(seq $n1 1 $n2);do
  nohup /bcftools-1.8/bcftools index -t out/fam_err"$i".vcf.gz &
done

/bcftools-1.8/bcftools concat <filename> -a -O z -o out/ALL_filtered_sorted.vcf.gz
/bcftools-1.8/bcftools concat out/fam_err1.vcf.gz out/fam_err2.vcf.gz out/fam_err3.vcf.gz -a -O z -o out/ALL_filtered_sorted.vcf.gz
/bcftools-1.8/bcftools concat out/fam_err1.vcf.gz out/fam_err2.vcf.gz out/fam_err3.vcf.gz out/fam_err4.vcf.gz out/fam_err5.vcf.gz out/fam_err6.vcf.gz out/fam_err7.vcf.gz out/fam_err8.vcf.gz out/fam_err9.vcf.gz out/fam_err10.vcf.gz -a -O z -o out/cankao_filtered_sorted.vcf.gz

cp out/ALL_filtered_sorted.vcf.gz /human/random3/0/
cp out/cankao_filtered_sorted.vcf.gz /human/random3/0/