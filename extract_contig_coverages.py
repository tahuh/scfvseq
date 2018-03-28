#!/usr/bin/python

"""
extract_contig_coverages.py

Extracts contig's coverage after rnaSPAdes run

Author : Sunghoon Heo
"""

import argparse
from Bio import SeqIO

parser = argparse.ArgumentParser()
parser.add_argument("--rnaspades_result", type=str, required=True, help="Resulting rnaSPAdes transcripts.fasta file")
parser.add_argument("--outfile_csv", type=str, required=True, help="Outfile in CSV format")

args = parser.parse_args()

outfile = open(args.outfile_csv , "w")
outfile.write("contig_id,coveage\n")
for record in SeqIO.parse(open(args.rnaspades_result),"fasta"):
    id = record.id
    cov = id.split("_")[-3]
    outfile.write(id + "," + cov + "\n")
outfile.close()
