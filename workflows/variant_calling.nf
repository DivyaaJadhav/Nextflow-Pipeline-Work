include { FASTP } from '../modules/fastp'
include { FASTQC } from '../modules/fastqc'
include { BWA_INDEX } from '../modules/bwa_index'
include { BWA_ALIGN } from '../modules/bwa_align'
include { SAMTOOLS_VIEW } from '../modules/samtools_view'
include { SAMTOOLS_SORT } from '../modules/samtools_sort'
include { SAMTOOLS_INDEX } from '../modules/samtools_index'
include { BCFTOOLS_CALL } from '../modules/bcftools_call'

workflow VARIANT_CALLING {
    take:
    reads_ch
    reference

    main:
    // Quality trimming with fastp
    FASTP(reads_ch)
    
    // Quality control with FastQC
    FASTQC(FASTP.out.trimmed_reads)
    
    // Index reference genome
    BWA_INDEX(reference)
    
    // Align reads to reference
    BWA_ALIGN(
        FASTP.out.trimmed_reads,
        reference,
        BWA_INDEX.out.index
    )
    
    // Convert SAM to BAM
    SAMTOOLS_VIEW(BWA_ALIGN.out.sam)
    
    // Sort BAM files
    SAMTOOLS_SORT(SAMTOOLS_VIEW.out.bam)
    
    // Index sorted BAM files
    SAMTOOLS_INDEX(SAMTOOLS_SORT.out.sorted_bam)
    
    // Call variants
    BCFTOOLS_CALL(
        SAMTOOLS_INDEX.out.indexed_bam,
        reference
    )

    emit:
    vcf = BCFTOOLS_CALL.out.vcf
}
