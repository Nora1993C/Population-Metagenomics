for i in $(ls *.fa);
do
/usr/local/blast-plus/blastp -db /home/Metagenome-2/Ref_database/TMA/cutC/cutC50 -query $i -out  $i.txt -evalue 1e-5 -outfmt 0 -max_target_seqs 3 -num_threads 56;
done
