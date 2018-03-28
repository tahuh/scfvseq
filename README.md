# scfvseq
Scfv-seq : a high-throuput pipeline for analyse antibody library
<br>
Note : The manuscript of this pipeline is under preparation. Do not copy or re-distribute source codes in this repo

## Pre-requisites
0. We have tested pipeline below under Ubuntu 14.04LTS OS
1. [Python 2.7](https://www.python.org/)
2. Must have installed [SPAdes](http://bioinf.spbau.ru/spades)
3. [BLASR](https://github.com/PacificBiosciences/blasr) must be installed
4. [BWA](http://bio-bwa.sourceforge.net/) and [Samtools](http://www.htslib.org/) must be installed on your system

## Before you run...
1. Change path 'RNASPADESBIN' in the assembly.sh
2. Change setup environment path of blasr.sh

## Pipeline execution sequence
1. Execute select_reads.sh
2. Execute assembly.sh
3. Execute select_contigs_with_coveragy.py
4. Execute select_contigs_woth_length_cutoff.py
5. Execute blasr.sh
6. Excute select_contigs_after_blasr.py

## Authors
Sunghoon Heo - Maintain this repository<br>
Byungjin Hwang - Collaborator
