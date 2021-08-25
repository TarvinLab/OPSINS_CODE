#!/bin/bash

# runs all analyses for detection of putative SWS2 pseudogene in Oophaga genome
# you will need to have BLAST and mafft installed for these analyses

# the first step is to make blast databases out of the genome assemblies
# run the make_blast_DB.sh script in the blastDB folder

# make a folder for output files
mkdir output


for frog in Oophaga Ranitomeya Rhinella;
do 
	printf "\n###############################\n"
	echo running $frog analyses
	echo "###############################"
	# running blast to determine the scaffold that contains LWS
	python2.7 run_blast.py ${frog} 0 6

	# find LWS scaffold at 1e-20 threshold
	myvar=$(cat output/LWS_results.${frog}.0.6.txt | awk '{if($11 < 1e-20) print $2}'| sort | uniq)
# 	echo $myvar

	# find LWS and reverse complement
	# python2.7 get_LWS_scaffolds.py pumilio_data/Oophaga_pumilio_P_RNA-scaffolded_genome.fasta $myvar > output/LWS_scaffold.fa
	# from Rogers et al. genome
	python2.7 get_LWS_scaffolds.py ../genome_sequences/${frog}.fa $myvar > output/LWS_scaffold.${frog}.fa 

	# make input file and align LWS scaffold to nanorana and known SWS2 sequences/LWS sequences
	cat ../input_sequences/LWS_${frog}_seq.fa > mafft.${frog}.input.fa
	cat output/LWS_scaffold.${frog}.fa >> mafft.${frog}.input.fa
	cat ../input_sequences/nanorana_LWS_SWS2_seq.fa >> mafft.${frog}.input.fa
	cat ../input_sequences/SWS2_example_seq.fa >> mafft.${frog}.input.fa

	# We tried many different options within mafft.  While these have a big effect on the 
	# reported alignments, generally none of these changes resulted in compelling candidate
	# SWS2 sequences in the Oophaga genome assembly

	# we used  MAFFT v7.453 (2019/Nov/8)
	# https://mafft.cbrc.jp/alignment/software/
	mafft --ep 1 mafft.${frog}.input.fa > output/mafft.${frog}.aligned_scaffolds.fa

	# if you wish to visualize the alignments you can use UGENE or another viewer, http://ugene.net/
	printf "\n##############################\n"
	echo finished $frog analyses, see output/mafft.${frog}.aligned_scaffolds.fa for results
	echo "##############################"

done
