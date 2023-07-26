#!/usr/bin/env nextflow



nextflow.enable.dsl=2


params.forwardreads = "/pfs/tc1/project/arcc-students/sthiongo/SiblingSubtraction/Practice/1854P_FwdPaired.fastq"
params.reversereads = "/pfs/tc1/project/arcc-students/sthiongo/SiblingSubtraction/Practice/1854P_RevPaired.fastq"



process bwaalignment {

        input:
                  path forwardreads
                  path reversereads
        output:
                  stdout 

        shell:

                  '''
                  module load bwa/0.7.17
                  module load arcc/1.0
                  module load gcc/12.2.0

                  bwa mem /project/arcc-students/sthiongo/Nextflow/work/87/90d257842aa4b3321de78f985615af/celegans_indexed !{forwardreads} !{reversereads} > celegans_aligned.sam
 
                  '''

}



workflow {

           bwaalignment (params.forwardreads, params.reversereads)

}
