#!/usr/bin/python

"""
Selecting trancripts after de novo assembly performed by assemblers

In our scFv study, we used rnaSPAdes as our default assembler

Author : Sunghoon Heo
"""
import argparse
from Bio import SeqIO
parser = argparse.ArgumentParser()
parser.add_argument("--length_min", type=int, required=True)
parser.add_argument("--length_max", type=int, required=True)
parser.add_argument("--infile", type=str, required=True)
parser.add_argument("--outfile", type=str, required=True)

args = parser.parse_args()

outfile_name = args.outfile
infile_name = args.infile
length_min = args.length_min
length_max = args.length_max

O = open(outfile_name, "w")
with open(infile_name) as F:
    id = ''
    seq = ''
    for record in SeqIO.parse(F, "fasta"):
        """
        if line[0] == '>':
            id = line.rstrip()
        else:
            seq = line.rstrip()
            if len(seq) >= length_min and len(seq) <= length_max:
                O.write(id + "\n" + seq + "\n")
        """
        id = record.id
        seq = str(record.seq)
        if len(seq) >= length_min and len(seq) <= length_max:
            O.write(">" + id + "\n" + seq + "\n")
O.close()
