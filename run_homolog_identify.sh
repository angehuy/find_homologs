#!/bin/bash
# Usage: ./run_homolog_identify.sh
# putting () around $(ls *.fna) bc the latter outputs ls as a single string while the former converts it into an array than can be iterated over

genomes=($(ls *.fna))
bed_files=($(ls *.bed))
query_file="HK_domain.faa"

# Loop through each genome and BED file
for i in ${!genomes[@]}; do
  genome=${genomes[$i]}
  bed_file=${bed_files[$i]}
  output_file="homolog_${genome%.fna}.txt"
  # genome%.fna= i.e. Escherichia_coli_K12.fna -> Escherichia_coli_K12
  # % is part of parameter expansion that allows string manipulaton
  
  # Run homolog_identify.sh script
  ./homolog_identify.sh "$query_file" "$genome" "$bed_file" "$output_file"
  
  # Output the number of genes identified
  echo "Number of genes identified in $output_file:"
  wc -l < "$output_file"
done
