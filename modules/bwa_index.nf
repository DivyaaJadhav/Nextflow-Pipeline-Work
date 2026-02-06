process BWA_INDEX {
    tag "${reference.baseName}"
    publishDir "${params.outdir}/bwa_index", mode: 'copy'

    input:
    path reference

    output:
    path "${reference}*", emit: index

    script:
    """
    ${params.bwa} index ${reference}
    """
}
