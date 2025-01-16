# Homolog Identification Scripts

## **homolog_identify.sh**
The `homolog_identify.sh` script performs the following tasks:
1. Uses BLAST to search a query file against a subject file.
2. Identifies putative homologs based on:
   - Percent identity greater than 30%.
   - Length of the aligned region being at least 90% of the query length.
3. Processes BLAST results and compares them to a BED file to determine if the putative homologs are located within (boundaries inclusive) gene boundaries.
4. Saves the names of genes with homologs into a `.txt` file.

---

## **run_homolog_identify.sh**
The `run_homolog_identify.sh` script automates the homolog identification process by:
1. Iterating through a directory containing `.faa` and `.bed` files.
2. Running the `homolog_identify.sh` script for each corresponding pair of `.faa` and `.bed` files.

---

## **Other Details**

### **Parameters**
- **pident**: Percent identical matches.
- **length**: Length of the aligned region between the query and subject.
- **query**: The query sequence being searched against the database.
- **sseqid**: The FASTA header in the subject file.

### **Miscellaneous**
- Use the flag `-task blastn-short` if the query sequence is shorter than 50 bases.
