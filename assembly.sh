#!/bin/bash

# POSIX variable
OPTIND=1

### Arguments
RNASPADESBIN="/Data2/BJ/hybrid_pacbio/pipeline/SPAdes-3.11.1-Linux/bin"
verbose=0
output_dir="./"
#adapter_fwd="AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG"
#adapter_rev="AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTNNNNNNNNGTGTAGATCTCGGTGGTCGCCGTATCATT"
ksize=117
threads=4
FILE1=''
FILE2=''

function show_help(){

echo "Pre-process for antibody library assembly"
echo "Usage : ./preprocess.sh [options]"
echo "[options]"
echo ""
echo "    -v         BOOL            verbose"
#echo "    -f         STR             FILE1 Illumina adapter default=AGATCGGAAGAGCACACGTCTGAACTCCAGTCACNNNNNNNNATCTCGTATGCCGTCTTCTGCTTG"
#echo "    -r         STR             FILE2 Illumina adapter default=AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTNNNNNNNNGTGTAGATCTCGGTGGTCGCCGTATCATT"
echo "    -o         STR             Output directory. default = ./"
echo "    -1         STR             Fastq FILE1"
echo "    -2         STR             Fastq FILE2"
echo "    -t         INT             Threads. default=4"
echo "    -k         INT             K-mer size default=117"
}

if [ $# -eq 0 ]
then
    show_help
	exit 0
fi

while getopts "h?vo:f:r:1:2:t:k:" opt; do
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
	f)
		adapter_fwd=$OPTARG
		;;
	r)
		adapter_rev=$OPTARG
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
	k)
		ksize=$OPTARG
		;;
	esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

#if [ $verbose -eq 1 ]
#then
#	echo "Output dir " , $output_dir
#	echo "Adapter fwd " , $adapter_fwd
#	echo "Adapter rev "  ,$adapter_rev
#	echo "FASTQ1 " , $FILE1
#	echo "FASTQ2 " , $FILE2
#	echo "THREADS " , $threads
#	echo "KSIZE " , $ksize 
#fi

#if [ $verbose -eq 1 ]
#then 
#	echo "Removing adapter sequences using AdapterRemoval"
#fi


# AdapterRemoval \
# --file1 $FILE1 \
# --file2 $FILE2 \
# --output1 "$output_dir"/adapter_trimmed_1.fastq \
# --output2 "$output_dir"/adapter_trimmed_2.fastq \
# --gzip \
# --adapter1 $adapter_fwd \
# --adapter2 $adapter_rev \
# --threads $threads

#if [ $verbose -eq 1 ]
#then 
#	echo "Done AdapterRemoval Step.\nPerform rnaSPAdes for initial assembly"
#fi

$RNASPADESBIN/spades.py \
--rna \
-o "$output_dir" \
-1 $FILE1 \
-2 $FILE2 \
-t $threads \
-k $ksize
