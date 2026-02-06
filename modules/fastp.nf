process FASTP {
    tag "${sample_id}"
    publishDir "${params.outdir}/fastp", mode: 'copy'

    input:
    tuple val(sample_id), path(read1), path(read2)

    output:
    tuple val(sample_id), path("${sample_id}_R1_trimmed.fastq.gz"), path("${sample_id}_R2_trimmed.fastq.gz"), emit: trimmed_reads
    path "${sample_id}_fastp.html", emit: html
    path "${sample_id}_fastp.json", emit: json

    script:
    """
    ${params.fastp} \
        -i ${read1} \
        -I ${read2} \
        -o ${sample_id}_R1_trimmed.fastq.gz \
        -O ${sample_id}_R2_trimmed.fastq.gz \
        -h ${sample_id}_fastp.html \
        -j ${sample_id}_fastp.json \
        --thread ${task.cpus} \
        --qualified_quality_phred 20 \
        --length_required 50
    """
}
