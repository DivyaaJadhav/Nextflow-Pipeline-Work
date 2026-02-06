process BWA_ALIGN {
    tag "${sample_id}"
    publishDir "${params.outdir}/bwa_align", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)
    path reference
    path index

    output:
    tuple val(sample_id), path("${sample_id}.sam"), emit: sam

    script:
    """
    ${params.bwa} mem \
        -t ${task.cpus} \
        -R "@RG\\tID:${sample_id}\\tSM:${sample_id}\\tPL:ILLUMINA" \
        ${reference} \
        ${read1} ${read2} \
        > ${sample_id}.sam
    """
}
