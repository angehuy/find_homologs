#!/bin/bash
# Usage: ./homolog_identify.sh <query file> <subject file> <bedfile> <outputfile>
  # ./homolog_identify.sh HK_domain.faa Wolbachia.fna Wolbachia.bed test_file_Wol

query_file=$1
subject_file=$2
bed_file=$3
output_file=$4

# temporary file to store BLAST results
tempfile=$(mktemp)

# 1) Find putative homologs  + perform tblastn search and filter results with awk
tblastn -query "$query_file" -subject "$subject_file" -outfmt "6 sseqid sstart send pident length qlen" | awk '$4 > 30 && $5 > 0.90 * $6' > "$tempfile"


# 2) Process each line of the BLAST results
while IFS=$'\t' read -r seqid1 sstart1 ssend1 pident length qlen; do
  # convert BLAST coordinates (1-based, inclusive end) to BED coordinates (0-based, inclusive end)
  sstart1=$((sstart1 - 1)) # since BED is 0 based
  ssend1=$((ssend1)) # since end isn't included so don't change
  
  # check each line of the BED file if sequence ID matches and if domain within gene boundaries (inclusive of gene start and stop)
  while IFS=$'\t' read -r seqid2 sstart2 ssend2 gene score strand; do
    if [[ "$seqid1" == "$seqid2" ]] && (( $sstart1 >= $sstart2 && $ssend1 <= $ssend2 )); then 
      if ! grep -qF "$gene" "$output_file"; then
        echo "$gene" >> "$output_file"
      fi
    fi
  done < "$bed_file"
done < "$tempfile"

rm "$tempfile"

echo "Saved to $output_file."
