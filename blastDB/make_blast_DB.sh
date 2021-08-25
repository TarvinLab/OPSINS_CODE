#!/bin/bash

# creates blastDB for all three databases
# you will need to have BLAST installed for these analyses
# change the path to makeblastDB in the make_blast_db python script

# we are not able to distribute genome data, so please download the data from 
# https://academic.oup.com/mbe/article/35/12/2913/5106668
# gunzip the file Oophaga.clean.newest.fa.gz and put it in the folder genome_sequences

# for nanorana, we have provided the annotated RNA file rna.fa.tar.gz file in genome_sequences 
# which you can upzip (tar xvzf rna.fa.tar.gz)

# For Rhinella marina, the genome is too large to be shared on github 
# you can find the fasta file at https://www.ncbi.nlm.nih.gov/assembly/GCA_900303285.1
# download and unzip it, then put it in the folder named genome_sequences


## rename each file by only the genus name + .fa
 
# Make blast dbs 
python2.7 make_blast_db.py ../genome_sequences/Oophaga.fa Oophaga 0
python2.7 make_blast_db.py ../genome_sequences/Ranitomeya.fa Ranitomeya 0
python2.7 make_blast_db.py ../genome_sequences/Nanorana.fa Nanorana 0
python2.7 make_blast_db.py ../genome_sequences/Rhinella.fa Rhinella 0