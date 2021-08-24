#!/bin/bash

# make protein sequences from nucloetide fasta
python2.7 translate_fasta.py infiles/SWS2_in_tree.noHyph.fasta > output/SWS2_in_tree.noHyph.With_tblastn.translated.fasta

# run a blast on the SWS2 sequences using the rhinella databse
python2.7 run_blast.SWS2.protein.py ../synteny/RhinellaDB/rhinella.0 7 

# make a fasta that now includes the results of the blast search, using hits with evals < 1e-10
python2.7 make_fasta_from_tblastn7.py 1e-10 output/SWS2_results.7.tblastn.txt ../synteny/rhinella_data/ONZH01.fasta >> output/SWS2_in_tree.noHyph.With_tblastn.translated.fasta 

# align results of BLAST to SWS2 sequences
mafft  output/SWS2_in_tree.noHyph.With_tblastn.translated.fasta  >  output/SWS2_in_tree.noHyph.With_tblastn.translated.mafft.fasta 
# visualize alignments in UGENE or similar viewer if desired.

#make nanorana database
#python2.7 make_blast_db.py infiles/rna.fa 0

# check for orhologs using blast with nanorana
python2.7 run_blast.nanorana.py ../../ranitomeya/genome_wide_SWS2_search/nanoranaDB/nanorana.0 6

# get best matching blast hit for each tblastn against Oophaga
python2.7 get_putative_ortholog_names.py output/Gene_annot_results.6.tblastn.txt infiles/rna.fa > output/most_similar_gene_in_nanorana.txt
