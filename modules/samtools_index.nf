process SAMTOOLS_INDEX {
    tag "${sample_id}"
    publishDir "${params.outdir}/samtools_sort", mode: 'copy'

    input:
    tuple val(sample_id), path(sorted_bam)

    output:
    tuple val(sample_id), path(sorted_bam), path("${sorted_bam}.bai"), emit: indexed_bam

    script:
    """
    ${params.samtools} index \
        -@ ${task.cpus} \
        ${sorted_bam}
    """
}
