#!/bin/bash
echo "Execution started."

Quality control threshold
CROET=0.5

Merge chromosomes
merge=yes # "yes" to merge, "no" to not merge

Select phasing software to use
AAA="Shapeit" # "eagle" or "Shapeit"

Select imputation software to use
BBB="Minimac4" # "Beagle", "Impute2", or "Minimac4"

Choose whether to perform liftover conversion
liftover="no" # "yes" to execute, "no" to skip

Set paths for necessary software
bgzipURL="/home/lizhuo/bcftools-1.8/htslib-1.8/bgzip"
bcftoolsURL="/home/lizhuo/bcftools-1.8/bcftools"

eagleURL="/home/lizhuo/human/soft/Eagle_v2.4.1/eagle"
eagleMAP="/date/genetic_map_hg38_withX.txt.gz"

shapeitURL="/home/lizhuo/human/soft/shapeit.v2.904.3.10.0-693.11.6.el7.x86_64/bin/shapeit"
shapeitMAP="/home/lizhuo/human/soft"

beagleURL="/home/lizhuo/human/soft/beagle.28Jun21.220.jar"
beagleMAP="/date/plink.all.GRCh38.map"

Minimac3URL="/home/lizhuo/human/soft/Minimac3Executable/bin/Minimac3"
Minimac4URL="/home/lizhuo/human/soft/Minimac3Executable/bin/Minimac3"
MinimacMAP="/home/lizhuo/human/soft/genetic_map_hg38_withX.txt"

impute2URL="/home/lizhuo/human/soft/impute_v2.3.2_x86_64_static/impute2"
vcf2impute_genURL="/home/lizhuo/human/soft/impute_v2.3.2_x86_64_static/vcf2impute_gen.pl"
vcf2impute_legend_hapsURL="/home/lizhuo/human/soft/impute_v2.3.2_x86_64_static/vcf2impute_legend_haps.pl"
impute2MAP="/date/g38.txt"

QCmainURL="/home/lizhuo/human/1/QCmain.jar"

getlifeover="/home/lizhuo/human/4/getlifeover.jar"
setliftover="/home/lizhuo/human/4/setliftover.jar"
liftOver="/home/lizhuo/human/4/liftOver"
liftOveMAP="/home/lizhuo/human/4/hg19ToHg38.over.chain.gz"

CROEURL="/home/lizhuo/human/10/CROE.jar"

Working directory
workURL="/date/human"

Directory for infile and refile on the server
infileURL="/date/data/indemo.vcf.gz"
refileURL="/date/data/redemoref.vcf.gz"

#1. Replace "chr" in chromosome names
mkdir -p $workURL/1/
cp $infileURL $workURL/1/demo.vcf.gz # Copy the infile from step 0 to the working directory of step 1
cp $refileURL $workURL/1/demoref.vcf.gz # Copy the refile from step 0 to the working directory of step 1

echo "{" > $workURL/1/configinf.json
echo -e "\t"word":"$workURL/1/"," >> $workURL/1/configinf.json
echo -e "\t"infile":"demo.vcf.gz"," >> $workURL/1/configinf.json
echo -e "\t"outfile":"demo.noChrID.vcf"," >> $workURL/1/configinf.json
echo -e "\t"finishfile":"finish.txt"," >> $workURL/1/configinf.json
echo -e "\t"errorfile":"error.txt"" >> $workURL/1/configinf.json
echo "}" >> $workURL/1/configinf.json

echo "{" > $workURL/1/configref.json
echo -e "\t"word":"$workURL/1/"," >> $workURL/1/configref.json
echo -e "\t"infile":"demoref.vcf.gz"," >> $workURL/1/configref.json
echo -e "\t"outfile":"demoref.noChrID.vcf"," >> $workURL/1/configref.json
echo -e "\t"finishfile":"finish.txt"," >> $workURL/1/configref.json
echo -e "\t"errorfile":"error.txt"" >> $workURL/1/configref.json
echo "}" >> $workURL/1/configref.json

java -jar $QCmainURL $workURL/1/configinf.json # Execute the operation to replace "chr" in the infile chromosome names
java -jar $QCmainURL $workURL/1/configref.json # Execute the operation to replace "chr" in the refile chromosome names

#2. Split infile and refile
mkdir -p $workURL/2/
cp $workURL/1/demo.noChrID.vcf.gz $workURL/2/ # Copy the infile from the first step to the working directory of the second step
cp $workURL/1/demoref.noChrID.vcf.gz $workURL/2/ # Copy the refile from the first step to the working directory of the second step

Pre-processing for bcftools as it requires its own compression format and index
gunzip $workURL/2/demo.noChrID.vcf.gz # Unzip the infile
$bgzipURL $workURL/2/demo.noChrID.vcf # Re-compress the infile
$bcftoolsURL index -t $workURL/2/demo.noChrID.vcf.gz # Create an index file for the infile

gunzip $workURL/2/demoref.noChrID.vcf.gz # Unzip the refile
$bgzipURL $workURL/2/demoref.noChrID.vcf # Re-compress the refile
$bcftoolsURL index -t $workURL/2/demoref.noChrID.vcf.gz # Create an index file for the refile

$bcftoolsURL query -f '%CHROM\n' $workURL/2/demo.noChrID.vcf.gz | uniq - $workURL/2/chrs.txt # Extract chromosomes from the infile

$bcftoolsURL query -f '%CHROM\n' $workURL/2/demoref.noChrID.vcf.gz | uniq - $workURL/2/refchrs.txt # Extract chromosomes from the refile

tempchrsstart=$(cat $workURL/2/chrs.txt | head -n 1)
tempchrs=$(cat $workURL/2/chrs.txt | tail -n 1)

#Split chromosomes of infile
for i in $(seq $tempchrsstart $tempchrs);do
$bcftoolsURL view -r $i $workURL/2/demo.noChrID.vcf.gz -o $workURL/2/chr$i.vcf.gz -O z
done

temprefchrsstart=$(cat $workURL/2/refchrs.txt | head -n 1)
temprefchrs=$(cat $workURL/2/refchrs.txt | tail -n 1)
for i in $(seq $temprefchrsstar $temprefchrs);do
$bcftoolsURL view -r $i $workURL/2/demoref.noChrID.vcf.gz -o $workURL/2/refchr$i.vcf.gz -O z
done

#3.Liftover conversion
mkdir -p $workURL/4/

for i in $(seq $tempchrsstart $tempchrs);do
cp $workURL/2/chr$i.vcf.gz $workURL/4/ # Copy the infile from the third step to the working directory of the fourth step
cp $workURL/2/refchr$i.vcf.gz $workURL/4/ # Copy the infile from the third step to the working directory of the fourth step
if [ "$liftover" == yes ];then
gzip -d $workURL/4/chr$i.vcf.gz # Unzip the infile file
echo "{" > $workURL/4/configget$i.json
echo -e "\t\"word\":\"$workURL/4/\"," >> $workURL/4/configget$i.json
echo -e "\t\"infile\":\"chr$i.vcf\"," >> $workURL/4/configget$i.json
echo -e "\t\"outfile\":\"chr$i.bed\"," >> $workURL/4/configget$i.json
echo -e "\t\"finishfile\":\"finishfile$i.txt\"," >> $workURL/4/configget$i.json
echo -e "\t\"errorfile\":\"error$i.txt\"," >> $workURL/4/configget$i.json
echo "}" >> $workURL/4/configget$i.json
java -jar $getlifeover $workURL/4/configget$i.json # Extract the bed file from the vcf.gz file

$liftOver $workURL/4/chr$i.bed $liftOveMAP $workURL/4/chr$i.new.bed $workURL/4/chr$i.error.bed # Perform liftover conversion

echo "{" > $workURL/4/configset$i.json
echo -e "\t\"word\":\"$workURL/4/\"," >> $workURL/4/configset$i.json
echo -e "\t\"vcffile\":\"chr$i.vcf\"," >> $workURL/4/configset$i.json
echo -e "\t\"bedfile\":\"chr$i.new.bed\"," >> $workURL/4/configset$i.json
echo -e "\t\"outfile\":\"chr$i.new.vcf\"," >> $workURL/4/configset$i.json
echo -e "\t\"finishfile\":\"finishfile$i.txt\"," >> $workURL/4/configset$i.json
echo -e "\t\"errorfile\":\"error$i.txt\"," >> $workURL/4/configset$i.json
echo "}" >> $workURL/4/configset$i.json
java -jar $setliftover $workURL/4/configset$i.json # Write the converted bed back into the vcf file

$bgzipURL -c $workURL/4/chr$i.new.vcf > $workURL/4/chr$i.vcf.gz # Compress the infile file
fi
done

#4.Phasing
mkdir -p $workURL/7/

for i in $(seq $tempchrsstart $tempchrs);do
cp $workURL/4/chr$i.vcf.gz $workURL/7/ # Copy the split files to the seventh step
done

for i in $(seq $temprefchrsstart $temprefchrs);do
cp $workURL/4/refchr$i.vcf.gz $workURL/7/ # Copy the split files to the seventh step
done

if [ "$AAA" == eagle ];then
mkdir -p $workURL/7/out/eagle/
for i in $(seq $tempchrsstart $tempchrs);do
gunzip $workURL/7/refchr$i.vcf.gz # Unzip the refile file
gunzip $workURL/7/chr$i.vcf.gz # Unzip the infile file
$bgzipURL $workURL/7/refchr$i.vcf # Re-compress the refile file
$bgzipURL $workURL/7/chr$i.vcf # Re-compress the infile file
$bcftoolsURL index -t $workURL/7/refchr$i.vcf.gz # Create an index for the refile
$bcftoolsURL index -t $workURL/7/chr$i.vcf.gz # Create an index for the infile
$eagleURL \
--vcfTarget $workURL/7/chr$i.vcf.gz \
--vcfRef $workURL/7/refchr$i.vcf.gz \
--geneticMapFile=$eagleMAP \
--outPrefix=$workURL/7/out/eagle/$i.eagle
done
fi

if [ "$AAA" == Shapeit ];then
mkdir -p $workURL/7/out/Shapeit/
for i in $(seq $tempchrsstart $tempchrs);do
gunzip $workURL/7/refchr$i.vcf.gz # Unzip the refile file
gunzip $workURL/7/chr$i.vcf.gz # Unzip the infile file
$bgzipURL $workURL/7/refchr$i.vcf # Re-compress the refile file
$bgzipURL $workURL/7/chr$i.vcf # Re-compress the infile file
$bcftoolsURL index -t $workURL/7/refchr$i.vcf.gz # Create an index for the refile
$bcftoolsURL index -t $workURL/7/chr$i.vcf.gz # Create an index for the infile

# Process refile into phased format
$shapeitURL \
--input-vcf $workURL/7/refchr$i.vcf.gz \
-O $workURL/7/demorefvcf.$i.phased 

# Process refile into impute format
$shapeitURL \
-convert \
--input-haps $workURL/7/demorefvcf.$i.phased  \
--output-ref $workURL/7/demorefvcf.$i

# Check whether snps in infile and refile are aligned, output non-aligned ones
$shapeitURL \
-check \
--input-vcf $workURL/7/chr$i.vcf.gz \
--input-ref $workURL/7/demorefvcf.$i.haplotypes $workURL/7/demorefvcf.$i.legend $workURL/7/demorefvcf.$i.samples \
--output-log $workURL/7/gwas.$i.alignments

# Start phasing
if [ ! -f "gwas.$i.alignments.snp.strand.exclude" ];then
	$shapeitURL \
	--input-vcf $workURL/7/chr$i.vcf.gz \
	--input-map $shapeitMAP/g38_chr$i.txt \
	--input-ref $workURL/7/demorefvcf.$i.haplotypes $workURL/7/demorefvcf.$i.legend $workURL/7/demorefvcf.$i.samples \
	-O $workURL/7/demo$i.phased 
else
	$shapeitURL \
	--input-vcf $workURL/7/chr$i.vcf.gz \
	--input-map $shapeitMAP/g38_chr$i.txt \
	--input-ref $workURL/7/demorefvcf.$i.haplotypes $workURL/7/demorefvcf.$i.legend $workURL/7/demorefvcf.$i.samples \
	--exclude-snp $workURL/7/gwas.$i.alignments.snp.strand.exclude \
	-O $workURL/7/demo$i.phased 
fi	

# Format conversion	
$shapeitURL \
-convert \
--input-haps $workURL/7/demo$i.phased \
--output-vcf $workURL/7/out/Shapeit/$i.Shapeit.vcf.gz

done
fi

#5.Imputation
mkdir -p $workURL/9/
cp -r $workURL/7/out/. $workURL/9/ # Copy all the vcf files from the 8th step to the working directory of the 9th step
cp $workURL/7/refchr*.vcf.gz $workURL/9/

for i in $(seq $tempchrsstart $tempchrs);do
gunzip $workURL/9/refchr$i.vcf.gz # Unzip the refile file
gunzip $workURL/9/$AAA/$i.$AAA.vcf.gz # Unzip the infile file
$bgzipURL $workURL/9/refchr$i.vcf # Re-compress the refile file
$bgzipURL $workURL/9/$AAA/$i.$AAA.vcf # Re-compress the infile file
$bcftoolsURL index -t $workURL/9/refchr$i.vcf.gz # Create an index for the refile
$bcftoolsURL index -t $workURL/9/$AAA/$i.$AAA.vcf.gz # Create an index for the infile
done

if [ "$BBB" == Minimac4 ];then
mkdir -p $workURL/9/out/Minimac4/
for i in $(seq $tempchrsstart $tempchrs);do
$Minimac3URL
--refHaps $workURL/9/refchr$i.vcf.gz
--processReference
--prefix $workURL/9/demoref$i.vcf.gz
--chr $i

if [ -f "$workURL/9/demoref$i.vcf.gz--chr.m3vcf.gz" ];then

Calculate (Minimac4)
$Minimac4URL
--refHaps $workURL/9/demoref$i.vcf.gz--chr.m3vcf.gz
--haps $workURL/9/$AAA/$i.$AAA.vcf.gz
--mapFile $workURL/9/$MinimacMAP
--prefix $workURL/9/out/Minimac4/$i.Minimac.vcf.gz
else
$Minimac4URL
--refHaps $workURL/9/demoref$i.vcf.gz.m3vcf.gz
--haps $workURL/9/$AAA/$i.$AAA.vcf.gz
--mapFile $MinimacMAP
--prefix $workURL/9/out/Minimac4/$i.Minimac.vcf.gz
fi
done
fi

if [ "$BBB" == Beagle ];then
mkdir -p $workURL/9/out/Beagle/
for i in $(seq $tempchrsstart $tempchrs);do
java -jar $beagleURL
gt=$workURL/9/$AAA/$i.$AAA.vcf.gz
ref=$workURL/9/refchr$i.vcf.gz
out=$workURL/9/out/Beagle/$i.Beagle.vcf.gz
map=$beagleMAP
done
fi

if [ "$BBB" == Impute2 ];then
mkdir -p $workURL/9/out/Impute2/
for i in $(seq $tempchrsstart $tempchrs);do

##Impute2###
$vcf2impute_genURL
-vcf $workURL/9/refchr$i.vcf.gz
-gen $workURL/9/demoref$i
##Convert refile file.

Format conversion
$vcf2impute_genURL
-vcf $workURL/9/$AAA/$i.$AAA.vcf.gz
-gen $workURL/9/demo$i

$vcf2impute_legend_hapsURL
-vcf $workURL/9/$AAA/$i.$AAA.vcf.gz
-leghap $workURL/9/demo$i
-chr $i

Perform imputation
$impute2URL
-m $impute2MAP
-h $workURL/9/demo$i.hap.gz
-l $workURL/9/demo$i.legend.gz
-g $workURL/9/demo$i.gz
-g_ref $workURL/9/demoref$i.gz
-int 1 5e6
-Ne 20000
-o $workURL/9/out/Impute2/$i.Impute2

done
fi


#66. Quality Control
mkdir -p $workURL/10/
cp -r $workURL/9/out/. $workURL/10/

for i in $(seq $tempchrsstart $tempchrs);do
echo "{" > $workURL/10/$BBB/config$i.json

echo -e "\t"word":"$workURL/10/$BBB/"," >> $workURL/10/$BBB/config$i.json
echo -e "\t"type":"$BBB"," >> $workURL/10/$BBB/config$i.json
echo -e "\t"threshold":"$CROET"," >> $workURL/10/$BBB/config$i.json

echo -e "\t"finishfile":"finishfile$i.txt"," >> $workURL/10/$BBB/config$i.json
echo -e "\t"errorfile":"error$i.txt"," >> $workURL/10/$BBB/config$i.json
echo -e "\t"outfile":"chr$i.vcf"," >> $workURL/10/$BBB/config$i.json

if [ "$BBB" == Impute2 ];then
echo -e "\t"infile":"$i.Impute2"," >> $workURL/10/$BBB/config$i.json
echo -e "\t"infofile":"$i.Impute2_info"," >> $workURL/10/$BBB/config$i.json
echo -e "\t"vcf":"$workURL/9/$AAA/$i.$AAA.vcf.gz"," >> $workURL/10/$BBB/config$i.json
elif [ "$BBB" == Beagle ];then
echo -e "\t"infile":"$i.Beagle.vcf.gz.vcf.gz"," >> $workURL/10/$BBB/config$i.json
elif [ "$BBB" == Minimac4 ];then
echo -e "\t"infile":"$i.Minimac.vcf.gz.dose.vcf.gz"," >> $workURL/10/$BBB/config$i.json
echo -e "\t"infofile":"$i.Minimac.vcf.gz.info"," >> $workURL/10/$BBB/config$i.json
else
echo "over"
fi
echo "}" >> $workURL/10/$BBB/config$i.json

java -jar $CROEURL $workURL/10/$BBB/config$i.json
done

echo "over"
