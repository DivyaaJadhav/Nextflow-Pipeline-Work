nextflow.enable.dsl=2

include { TRIM_AND_QC } from './workflows/workflow.nf'
include { FASTQC }      from './modules/fastqc.nf'
include { CUTADAPT }    from './modules/cutadapt.nf'

workflow {
    TRIM_AND_QC()
}
