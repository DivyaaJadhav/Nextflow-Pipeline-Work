#!/usr/bin/env nextflow

/*
 * Variant Calling Pipeline
 * Author: DivyaaJadhav
 * Description: A complete Nextflow pipeline for variant calling from FASTQ to VCF
 */

include { VARIANT_CALLING } from './workflows/variant_calling'

// Print pipeline header
log.info """
=========================================
 VARIANT CALLING PIPELINE
=========================================
 Reference genome : ${params.reference}
 Reads directory  : ${params.reads}
 Output directory : ${params.outdir}
=========================================
"""

workflow {
    // Create channel for paired-end reads
    reads_ch = Channel
        .fromFilePairs("${params.reads}/*_R{1,2}*.fastq.gz", checkIfExists: true)
        .map { sample_id, reads -> tuple(sample_id, reads[0], reads[1]) }
        .view { "Processing sample: ${it[0]}" }
    
    // Reference genome
    reference = file(params.reference, checkIfExists: true)
    
    // Run variant calling workflow
    VARIANT_CALLING(reads_ch, reference)
}

workflow.onComplete {
    log.info """
    =========================================
    Pipeline completed at: ${workflow.complete}
    Execution status: ${workflow.success ? 'SUCCESS' : 'FAILED'}
    Duration: ${workflow.duration}
    =========================================
    """
}
