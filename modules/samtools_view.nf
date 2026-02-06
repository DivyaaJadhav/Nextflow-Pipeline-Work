process SAMTOOLS_VIEW {
    tag "${sample_id}"
    publishDir "${params.outdir}/samtools_view", mode: 'copy'

    input:
    tuple val(sample_id), path(sam)

    output:
    tuple val(sample_id), path("${sample_id}.bam"), emit: bam

    script:
    """
    ${params.samtools} view \
        -@ ${task.cpus} \
        -b \
        -h \
        -o ${sample_id}.bam \
        ${sam}
    """
}
