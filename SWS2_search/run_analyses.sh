#!/bin/bash

mkdir output


for frog in Ranitomeya Oophaga Rhinella
do

	# make protein sequences from nucloetide fasta
	python2.7 translate_fasta.py ../input_sequences/SWS2_all.fasta > output/SWS2_all_${frog}_tblastn.translated.fasta

	# run a blast on the SWS2 sequences using each databse
	python2.7 run_blast.SWS2.protein.py ${frog} 7 

	# make a fasta that now includes the results of the blast search, using hits with evals < 1e-10
	python2.7 make_fasta_from_tblastn7.py 1e-10 output/SWS2_results.${frog}.7.tblastn.txt ../genome_sequences/${frog}.fa >> output/SWS2_all_${frog}_tblastn.translated.fasta 

	# align results of BLAST to SWS2 sequences
	mafft output/SWS2_all_${frog}_tblastn.translated.fasta  >  output/SWS2_all_${frog}_tblastn.translated.mafft.fasta 

	# visualize alignments in UGENE or similar viewer if desired.

	# change directory to wherever raxML is on your machine
	#cd ~/projects/pop_gen_software/standard-RAxML-master
	#./raxmlHPC-SSE3 -m PROTGAMMALGF -s ~/projects/poison/LWS_blast/SWS2_in_tree.noHyph.With_tblastn.translated.mafft.fasta -p 12345 -n treeAllSeqs
	# this tree will probably not look great because the alignments are not highly tuned -- we tried several different approaches (largely changing
	# the options in mafft and subsetting the aligments down to the regions of highest sequence similarity), but none of the trees suggested that
	# any of the candidate sequences were likely to be SWS2 pseudogenes


	# check for orhologs using blast with nanorana
	python2.7 run_blast.nanorana.py ${frog} 6

	# get best matching blast hit for each tblastn against Oophaga
	python2.7 get_putative_ortholog_names.py output/Gene_annot_results.${frog}.SWS2.6.tblastn.txt ../genome_sequences/Nanorana.fa > output/most_similar_gene_in_nanorana_SWS2_${frog}.txt
done