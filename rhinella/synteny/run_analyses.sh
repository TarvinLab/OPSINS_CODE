#!/bin/bash

# runs all analyses for detection of putative SWS2 pseudogene in Oophaga genome
# you will need to have BLAST and mafft installed for these analyses

# the first step is to make a database out of the Oophaga genome assembly
# we are not able to distribute this data, so please download the data from 
# https://academic.oup.com/mbe/article/35/12/2913/5106668
# gunzip the file Oophaga.clean.newest.fa.gz and put it in the folder pumilio_data
 
# Make blast db
python2.7 make_blast_db.py ../rhinella_data/GCA_900303285.1_RM170330_genomic.fna 0

# running blast to determine the scaffold that contains LWS
python2.7 run_blast.py RhinellaDB/rhinella.0 0 6

# find LWS scaffold at 1e-20 threshold
myvar=$(cat output/LWS_results.0.6.txt | awk '{if($11 < 1e-20) print $2}'| sort | uniq)

# find LWS and reverse complement
python2.7 get_LWS_scaffolds.py rhinella_data/ONZH01.fasta $myvar > output/LWS_scaffold.fa

# we used  MAFFT v7.453 (2019/Nov/8)
# https://mafft.cbrc.jp/alignment/software/

mafft --ep 2 --op 2 --add output/LWS_scaffold.fa infiles/SWS2_in_tree.fa > output/mafft.alignedSWS2.fa
mafft --ep 2 --op 2 --add output/LWS_scaffold.fa infiles/LWS_in_tree.fa > output/mafft.alignedLWS.fa

# if you wish to visualize the alignments you can use UGENE or another viewer, http://ugene.net/
# the SWS2 and LWS sequences are both present in the same contig, about 18Kb apart from each other
