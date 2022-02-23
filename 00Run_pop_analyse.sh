#!/bin/bash
##############################
cd /home/Metagenome-2/Func-Genes/TMA/cutc
#cp -r ../../../Pep-Seq/Asprin .
cd PHT               #change populations
mkdir 0_seq-fa
mkdir 1_blast-result
mkdir 2_ori-anno
mkdir 3_Anno
mkdir 4_Abundance
mkdir 5_results
mkdir 6_Gene-taxa-abundance
############################0_seq-fa Blast#######################################
mv *.fa 0_seq-fa
cd 0_seq-fa
cp ../../bin/0_Blast_TMA.sh .  
./0_Blast_TMA.sh
mv *.txt ../1_blast-result

############################1_blast-result#######################################
cd ../1_blast-result
for i in *.txt; do mv $i `echo $i|sed "s/\.fa.txt/\.blastp/"`; done;
ls *.blastp > Samples.txt
perl -pi -e "s/.blastp//" Samples.txt
cp -r ../../bin/tabs .                   
cp ../../bin/TMA_core_Anno.pm .        
cp ../../bin/TMA_core_Anno.pl .        
perl TMA_core_Anno.pl Samples.txt
mv *.anno ../2_ori-anno

############################2_ori-anno#######################################
cd ../2_ori-anno
cp ../../bin/2_Anno_add_SamID.pl .                
perl 2_Anno_add_SamID.pl

############################3_Anno#######################################
cd ../3_Anno
cp ../../bin/3.1_Anno_extract_Length.pl .         
cp ../../bin/3.2_Abun_extract_abundance.pl .      
cp ../../bin/3.3_Anno_extract_gene_indi.pl .  
cp ../../bin/3.4_Abun_extract_abundance.pl .    
perl 3.1_Anno_extract_Length.pl
perl 3.2_Abun_extract_abundance.pl
perl 3.3_Anno_extract_gene_indi.pl
perl 3.4_Abun_extract_abundance.pl
mv *.txt ../4_Abundance

############################4_Abundance#######################################
cd ../4_Abundance
cp ../../bin/4_Abun_extract_gene_indi.pl .           
perl 4_Abun_extract_gene_indi.pl

############################5_results#######################################
cd ../5_results
cp ../../bin/5_Anno_extract-new.pl .                
perl 5_Anno_extract-new.pl

############################6_Gene-taxa-abundance##################################
cd ../6_Gene-taxa-abundance
cp ../../bin/6.1_extract_abundance_all.pl . 
cp ../../bin/6.2_extract_taxa_abundance.pl . 
cp ../../ref_genome/4_GeneAssignMent/Hits_Gene_taxa.txt .
perl 6.1_extract_abundance_all.pl
perl 6.2_extract_taxa_abundance.pl
mkdir tt
mv *.hit.abun.txt tt/
########################################
