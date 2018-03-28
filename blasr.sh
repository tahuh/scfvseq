#!/bin/bash

source /Data2/BJ/hybrid_pacbio/programs_test/pbjelly/PBSuite_15.8.24/setup.sh
source /opt/mybuild/setup-env.sh

### align to 1,000 pool enz reads

blasr -m 4 /Data2/BJ/hybrid_pacbio/random/100/assembly/k117/transcripts_cov2000_min700_max1400.fasta \
/Data2/BJ/scFv/random_N/100_1000_old_pacbio/100_ENZ.fasta --sa \
/Data2/BJ/scFv/random_N/100_1000_old_pacbio/100_ENZ.fasta.sa --nproc 16 > /Data2/BJ/hybrid_pacbio/random/100/assembly/k117/transcipts_enz_aligned_cov2000_min700_max1400.fasta.m4


### align to 1,000 pool pcr reads

# blasr -m 4 /Data2/BJ/hybrid_pacbio/random/1000/assembly/transcripts_cov7000_min700_max1400.fasta \
# /Data2/BJ/hybrid_pacbio/pacbio_data/random/1000/1000_pcr_reads.fasta --sa \
# /Data2/BJ/hybrid_pacbio/pacbio_data/random/1000/1000_pcr_reads.fasta.sa --nproc 16 > Data2/BJ/hybrid_pacbio/random/1000/assembly/transcipts_pcr_aligned_cov7000_min700_max1400.fasta.m4
