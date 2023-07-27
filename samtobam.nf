#!/usr/bin/env nextflow

nextflow.enable.dsl=2


params.alignedreads = "/pfs/tc1/project/arcc-students/sthiongo/SiblingSubtraction/Practice/celegans_aln-pe.sam"


process samtobam {


        input:

                  path alignedreads

        output:

                  stdout

        shell:

                  '''
                  module load samtools/1.16.1
                  module load arcc/1.0
                  module load gcc/12.2.0
                  samtools view -f 3 !{alignedreads} -o celegans_aln-peflags3.sam -h -@4
                  samtools view -b celegans_aln-peflags3.sam -o celegans_aln-peflags3.bam -@4
                  samtools sort celegans_aln-peflags3.bam -o celegans_aln-peflags3_sorted.bam -@4
                  samtools index celegans_aln-peflags3_sorted.bam
                
                  '''

}

workflow {
           samtobam(params.alignedreads)
}
