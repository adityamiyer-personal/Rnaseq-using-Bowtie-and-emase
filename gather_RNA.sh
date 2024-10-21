paste BXD98-RNA.genes.expected_read_counts BXD99-RNA.genes.expected_read_counts | cut -f 1,4,8 > example_rna_counts.txt
sed -i '1d' example_rna_counts.txt
sed -i '1igene\tBXD98\tBXD99' example_rna_counts.txt
