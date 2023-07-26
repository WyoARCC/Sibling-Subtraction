#!/usr/bin/env nextflow

nextflow.enable.dsl=2

params.reference = "/pfs/tc1/project/arcc-students/sthiongo/SiblingSubtraction/Practice/c_elegans.WS235.genomic.fa"

process bwaindex {

        input:
                  path reference

        output:
                  stdout 

        shell:

                  '''
                  module load bwa/0.7.17
                  module load arcc/1.0
                  module load gcc/12.2.0
                  bwa index -a bwtsw -p celegans_indexed !{reference} 
                  '''
}


workflow {
           bwaindex(params.reference)
}
