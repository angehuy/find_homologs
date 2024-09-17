homolog_identify.sh script
- uses BLAST to search a query file against a subject file
- identifies putative homologs based on percent identity greater than 30 and length of aligned region being at least 90% the length of the query length
- processes BLAST results and compares to a BED file to see if the putative homologs are located within (boundaries inclusive) gene boundaries
- saves gene names into a .txt file

run_homolog_identify.sh script
- iterates through a directory containing .faa and .bed files and for each corresponding pair, runs the homolog_identify.sh script

other details
parameters
- pident: percent identical matches
- length: length of aligned region between query and subject
- query: the singular piece you have and are searching against db
- sseqid: fasta header in subject file
misc
- use the flag "-task blastn-short" if the query sequence is shorter than 50 bases