#!/usr/bin/python

"""
Must give input as rnaSPAdes's output
"""
import argparse
from Bio import SeqIO

parser = argparse.ArgumentParser()
parser.add_argument("--infile" , type=str, required=True)
parser.add_argument("--outfile", type=str, required=True)
parser.add_argument("--covcut", type=float, required=True)
parser.add_argument("--aux", type=str, required=False)
parser.add_argument("--use_aux", default=False, action="store_true")
def process_aux(infilename, auxfilename,c ):
    # Build map
    M = {}
    ret = {}
    for line in open(auxfilename):
        data = line.rstrip().split()
        M[data[0]] = data[1]
    for record in SeqIO.parse(open(infilename) , "fasta"):
        seq = str(record.seq)
        id = record.id
        if float(M[id]) < c:
            continue
        ret[id] = seq
    return ret
args = parser.parse_args()
if args.use_aux:
    contigs = process_aux(args.infile, args.aux,args.covcut)
else:
    contigs = {}
    for record in SeqIO.parse(open(args.infile) , "fasta"):
        coverage = float(record.id.split("_")[-3])
        if coverage >= args.covcut:
            contigs[record.id] = str(record.seq)

with open(args.outfile , "w") as O :
    for id , seq in contigs.items():
        O.write(">" + id + "\n" + seq + "\n")
