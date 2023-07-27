# Sibling-Subtraction
Creating an automated nextflow workflow to analyze &amp; compare genome sequences of sibling nematodes.
As of 7/27/2023, individual nextflow scripts have been written to evaluate sequence qualities with FastQC, index a reference genome with BWA, align to an indexed reference genome with BWA, and convert aligned .sam files to a .bam format with samtools, respectively.
