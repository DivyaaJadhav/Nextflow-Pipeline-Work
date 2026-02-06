process SAMTOOLS_SORT {
    tag "${sample_id}"
    publishDir "${params.outdir}/samtools_sort", mode: 'copy'

    input:
    tuple val(sample_id), path(bam)

    output:
    tuple val(sample_id), path("${sample_id}.sorted.bam"), emit: sorted_bam

    script:
    """
    ${params.samtools} sort \
        -@ ${task.cpus} \
        -o ${sample_id}.sorted.bam \
        ${bam}
    """
}
