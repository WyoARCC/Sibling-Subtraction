#!usr/bin/env nextflow
nextflow.enable.dsl=2


params.csv='/project/arcc-students/SiblingSubtraction/RealData.csv'
params.output='/project/arcc-students/SiblingSubtraction/fastqc_out'


// Run FastQC on the left read and right read of each sample
process FastQC {
	input:
	tuple val(L_read), val(R_read)
	val out

	output:
	env imgdir

	shell:
	'''
	fastqc !{L_read} !{R_read} --outdir=!{out} --extract
	imgdir="!{out}/all_per_base_quality"
	'''
}

process ImgRelocate {
	input:
	tuple val(L_read),val(R_read)
	val out

	output:
	stdout
	
	shell:
	'''
	imgdir="!{out}/all_per_base_quality"
	mkdir -p ${imgdir}
	
	L=!{L_read}
	L2=${L##*/}
	L_folder="${L2%%.*}_fastqc"
	cp "!{out}/${L_folder}/Images/per_base_quality.png" "${imgdir}/${L_folder}_per_base_quality.png"

	R=!{R_read}
	R2=${R##*/}
	R_folder="${R2%%.*}_fastqc"
	cp "!{out}/${R_folder}/Images/per_base_quality.png" "${imgdir}/${R_folder}_per_base_quality.png"
	'''
}

workflow {
	// Take the input csv file and split it such that the contents of each column are placed into a queue channel for that column
	Channel
		.fromPath(params.csv)
		.splitCsv(header:true)
		.map{row-> tuple(file(row.L_Reads), file(row.R_Reads))}
		.set{csv_values}

	// Run FastQC on the filepaths from the csv file
	FastQC(csv_values,params.output).set{out}

	ImgRelocate(csv_values,out)
}
