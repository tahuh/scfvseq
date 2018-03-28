#!/usr/bin/python

import argparse
import sys

try:
    from Bio import SeqIO
    BIOPY=True
except ImportError:
    from SequenceParser import FAParser
    BIOPY=False
parser = argparse.ArgumentParser()
parser.add_argument("--fasta", type=str,required=True, help="Input FASTA after coverage/length cutoff")
parser.add_argument("--m4", type=str, required=True, help="BLASR output")
parser.add_argument("--similarity", type=float, required=False, help="Alignment similarity by BLASR. default=0.99",default=0.99)
parser.add_argument("--outfile", type=str ,required=True, help="Result FASTA file")

args = parser.parse_args()

fasta = args.fasta
m4 = args.m4
sim = args.similarity
out = args.outfile
stdout = sys.stdout

def ReadFastaFile(fname, use_biopy=False):
    d = {} ### id to sequence
    if use_biopy:
        with open(fname) as F:
            for record in SeqIO.parse(F, 'fasta'):
                d[record.id] = str(record.seq)
    else:
        p = FAPraer(fname)
        p.open()
        for id, desc, seq in p.parse():
            d[id] = seq
    return d

def ReadM4(m4file):
    rec = {}
    with open(m4file) as m4:
        for line in m4:
            data = line.rstrip().split()
            s = float(data[3])
            qname = data[0].split("/")[0]
            rec[qname] = s
    return rec

stdout.write("Reading FASTA input file %s\n"%(fasta))
fasta_record = ReadFastaFile(fasta , use_biopy=BIOPY)
stdout.write("Reading m4 file %s\n"%(m4))
m4_record = ReadM4(m4)

proper = []
stdout.write("Select contigs with respect to alignment similarity (%f) given\n"%(sim))

for id , value in m4_record.items():
    if value >= sim:
        proper.append(id)

stdout.write("Flush to selected contigs\n")

O = open(out , "w")
for p in proper:
    try: seq = fasta_record[p]
    except KeyError: continue
    O.write(">" + p + "\n" + seq + "\n")
O.close()
