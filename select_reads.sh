#!/bin/bash

##########################################
#
# select_reads.sh
#
# selects reads before scfv-seq pipeline
#
# program requirements : BWA , SAMtools
#
##########################################


function show_help(){

echo "Pre-selects reads for antibody library assembly"
echo "Usage : ./select_reads.sh [options]"
echo "[options]"
echo ""
echo "    -v         BOOL            verbose"
echo "    -o         STR             Output directory. default = ./"
echo "    -1         STR             Fastq FILE1"
echo "    -2         STR             Fastq FILE2"
echo "    -s         STR             Sample prefix. default=sample"
echo "    -r         STR             Reference backbone sequence FASTA file"
echo "    -t         INT             Threads. default=4"
echo
}

verbose=0
output_dir="./"
threads=4
FILE1=''
FILE2=''
SAMPLE="sample"
VECTOR=""
if [ $# -eq 0 ]
then
    show_help
	exit 0
fi

while getopts "h?vo:1:2:t:s:r:" opt; do
	case "$opt" in
	h|\?)
		show_help
		exit 0
		;;
	v)
		verbose=1
		;;
	o)
		output_dir=$OPTARG
		;;
	1)
		FILE1=$OPTARG
		;;
	2)
		FILE2=$OPTARG
		;;
	t)
		threads=$OPTARG
		;;
	s)
		SAMPLE=$OPTARG
		;;
	r)
		VECTOR=$OPTARG
		;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

if [ $verbose -eq 1 ]
then
	echo "Output dir " , $output_dir
	echo "FASTQ1 " , $FILE1
	echo "FASTQ2 " , $FILE2
	echo "THREADS " , $threads
	echo "SAMPLE NAME " , %SAMPLE
fi


if [ $verbose -eq 1 ]
then
	echo "Mapping back to backbone"
fi

if [ ! -d "$output_dir"/tmp ]
then
	mkdir "$output_dir"/tmp
fi

if [ ! -d "$output_dir"/bam ]
then
	mkdir "$output_dir"/bam
fi


echo -n 'Align start : ' ; date;

bwa index $VECTOR

bwa mem -t 4 -M -R '@RG\tID:'$SAMPLE'\tLB:'$SAMPLE'\tPL:ILLUMINA\tPU:'$SAMPLE "$VECTOR" "$FILE1" "$FILE2" > "$output_dir"/tmp/"$SAMPLE".sam

samtools view -b -T "$VECTOR" -S "$output_dir"/tmp/"$SAMPLE".sam -o "$output_dir"/tmp/"$SAMPLE".bam

samtools sort "$output_dir"/tmp/"$SAMPLE".bam "$output_dir"/bam/"$SAMPLE".bam.sorted

samtools index "$output_dir"/bam/"$SAMPLE".bam.sorted.bam

echo -n 'Cleaning tmp files...' ; date;

rm "$output_dir"/tmp/"$SAMPLE".sam
rm "$output_dir"/tmp/"$SAMPLE".bam

if [ $verbose -eq 1 ]
then
	echo "Done mapping..."
fi

if [ $verbose -eq 1 ]
then
	echo "Extracting reads"
fi


if [ ! -d "$output_dir"/tmp ]
then
	mkdir "$output_dir"/tmp
fi


if [ ! -d "$output_dir"/fastq ]
then
	mkdir "$output_dir"/fastq
fi	


BAM_IN="$output_dir"/bam/"$SAMPLE".bam.sorted.bam
s=$BAM_IN
s=${s##*/}
s=${s%.bam}

echo "SAMTOOLS"
samtools view -b -f 4 -f 8 "$BAM_IN" > "$output_dir"/tmp/"$s".unmapped.bam

samtools index "$output_dir"/tmp/"$s".unmapped.bam

samtools bam2fq "$output_dir"/tmp/"$s".unmapped.bam > "$output_dir"/tmp/"$s".unmapped.fastq

cat "$output_dir"/tmp/"$s".unmapped.fastq | grep '^@.*/1$' -A 3 --no-group-separator > "$output_dir"/fastq/"$s"_unmapped.r1.fastq
cat "$output_dir"/tmp/"$s".unmapped.fastq | grep '^@.*/2$' -A 3 --no-group-separator > "$output_dir"/fastq/"$s"_unmapped.r2.fastq

rm "$output_dir"/tmp/"$s".unmapped.fastq
rm "$output_dir"/tmp/"$s".unmapped.bam

if [ $verbose -eq 1 ]
then
	echo "Done extraction"
fi