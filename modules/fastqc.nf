process FASTQC {
    tag "${sample_id}"
    publishDir "${params.outdir}/fastqc", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    path "*.html", emit: html
    path "*.zip", emit: zip

    script:
    """
    ${params.fastqc} \
        -t ${task.cpus} \
        -o . \
        ${read1} ${read2}
    """
}
