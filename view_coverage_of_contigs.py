#!/usr/bin/python

import pandas as pd
import mathplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import argparse

import sys

usage = "./view_coverage_of_contigs.py coverage.csv"

if len(sys.argv) < 2:
    sys.stdout.write(usage)
    exit(-1)

df = pd.read_csv(sys.argv[1])
sorted_df = df.sort_values("coverage",ascending=False)
colors = [ "black" for _ in sorted_df["coverage"] ]
radii = [ 3 for _ in sorted_df["coverage"] ]
radii = np.array(radii)
circles = np.pi * (radii ** 2)
plt.xlabel("Contig Index[Decending by coverage]")
plt.ylabel("Coverage from rnaSPAdes")
plt.scatter(x=range(len(sorted_df)) , y = sorted_df["coverage"], s = circles, c = colors)
plt.show()
