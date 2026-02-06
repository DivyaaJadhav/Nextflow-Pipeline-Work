process BCFTOOLS_CALL {
    tag "${sample_id}"
    publishDir "${params.outdir}/bcftools_call", mode: 'copy'

    input:
    tuple val(sample_id), path(sorted_bam), path(bam_index)
    path reference

    output:
    tuple val(sample_id), path("${sample_id}.vcf.gz"), emit: vcf

    script:
    """
    ${params.bcftools} mpileup \
        -f ${reference} \
        -Ou \
        ${sorted_bam} | \
    ${params.bcftools} call \
        -mv \
        -Oz \
        -o ${sample_id}.vcf.gz
    
    ${params.bcftools} index ${sample_id}.vcf.gz
    """
}
