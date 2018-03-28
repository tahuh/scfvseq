# scfvseq
Scfv-seq : a high-throuput pipeline for analyse antibody library
<br>
Note : The manuscript of this pipeline is under preparation. Do not copy or re-distribute source codes in this repo

## Pre-requisites
1. [Python 2.7](https://www.python.org/)
2. [BioPython](http://biopython.org/) library required for sequence data parsing
3. [Matplotlib](https://matplotlib.org/) required for data visualization
4. [Pandas](https://pandas.pydata.org/) required for data visualization
5. [NumPy](http://www.numpy.org/) required for data visualization
6. [Seaborn](https://seaborn.pydata.org/) required for data visualization
6. Must have installed [SPAdes](http://bioinf.spbau.ru/spades)
7. [BLASR](https://github.com/PacificBiosciences/blasr) must be installed
8. [BWA](http://bio-bwa.sourceforge.net/) and [Samtools](http://www.htslib.org/) must be installed on your system

### System requirements
We have tested pipeline below under Ubuntu 14.04LTS OS

## Before you run...
1. Change path 'RNASPADESBIN' in the assembly.sh
2. Change setup environment path of blasr.sh

## Pipeline execution sequence
1. Execute select_reads.sh
2. Execute assembly.sh
3. Run extract_contig_coverages.py
4. Run view_coverage_of_contigs.py
5. Execute select_contigs_with_coveragy.py
6. Execute select_contigs_woth_length_cutoff.py
7. Execute blasr.sh
8. Excute select_contigs_after_blasr.py

## Authors
Sunghoon Heo - Maintain this repository<br>
Byungjin Hwang - Collaborator
