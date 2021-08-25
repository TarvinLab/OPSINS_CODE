This directory contains code for the genome mining analyses described in Wan et al

To run these analyses, follow these steps:

1. Decompress the Nanorana rna.fa.tar.gz files (tar xvzf rna.fa.tar.gz) in the genome_sequences folder
2. The other genome files are too large to be shared on github. 
You need to download them into the genome_sequences folder and rename them with convention <genus>.fa
	- Rhinella: https://www.ncbi.nlm.nih.gov/assembly/GCA_900303285.1
	- Oophaga: https://www.ncbi.nlm.nih.gov/assembly/GCA_009801035.1/ (rescaffolded: https://zenodo.org/record/3696842#.XuHmN0GxWUk)
	- Ranitomeya: https://www.ncbi.nlm.nih.gov/assembly/GCA_905332335.1/
3. Install mafft and blast on your computer and alter paths in the scripts with "blast" in the title
4. Generate the blast databases by running the make_blast_DB.sh script in the blastDB folder
5. run the other analyses using the run_analyses.sh scripts in the "synteny", "SWS2_search", and "LWS_search" folders

The annotated ortholog files (i.e., the lowest blast E-value with Nanorana) are labeled as the most_similar_gene_in_nanorana_<gene>_<frog>.txt in the output folders of each analysis folder
