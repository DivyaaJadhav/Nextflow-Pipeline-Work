nextflow.enable.dsl=2

process CUTADAPT {

    publishDir "${params.output}/cutadapt", mode: 'copy'

    input:
    path file

    output:
    path "${file.baseName}.trimmed.fastq.gz"

    script:
    """
    ${params.cutadapt_bin} \
        -a ${params.adapter} \
        -o ${file.baseName}.trimmed.fastq.gz \
        ${file}
    """
}
