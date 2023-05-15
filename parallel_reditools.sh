#!/bin/bash









REFERENCE="/mnt/iquityazurefileshare1/GTFs/GRCh38.primary_assembly.genome.fa"







# removed alternates from .fai because they cause REDItools to fail if there is a period in the name of the region


SIZE_FILE="/mnt/iquityazurefileshare1/GTFs/GRCh38.primary_assembly.genome.fa.fai
"


REDI_FOLDER="/home/azureuser/reditools2.0"


NUM_CORES=4







# Samples using for 5v5 test:


# MS1-{}-P-NN_seq.sorted.STAR_Ev104.cufflinks.bam: 11001, 11002, 11006, 11008, 11015


# HC1-{}-P-HC_seq.sorted.STAR.Ev104.cufflinks.bam: 11225, 11226, 11227, 11228, 11229







# replace with files for REDItools RES generation


FILE1="MS1-11001-P-NN_seq"


FILE2="MS1-11002-P-NN_seq"


FILE3="MS1-11006-P-NN_seq"


FILE4="MS1-11008-P-NN_seq"


FILE5="MS1-11015-P-NN_seq"


FILE6="HC1-11225-P-HC_seq"


FILE7="HC1-11226-P-HC_seq"


FILE8="HC1-11227-P-HC_seq"


FILE9="HC1-11228-P-HC_seq"


FILE10="HC1-11229-P-HC_seq"







for FILE in $FILE1 $FILE2 $FILE3 $FILE4 $FILE5 $FILE6 $FILE7 $FILE8 $FILE9 $FILE10


do


   mkdir -p "$REDI_FOLDER/$FILE-outputs/parallel/temp"


   mkdir -p "$REDI_FOLDER/$FILE-outputs/parallel/output"


   mkdir -p "$REDI_FOLDER/$FILE-outputs/parallel/coverage"







   SOURCE_BAM_FILE="/mnt/iquityazurefileshare1/Test/MiniTestData_HCvMN/bam
/$FILE.sorted.STAR.Ev104.cufflinks.bam"


   OUTPUT_FILE="$REDI_FOLDER/$FILE-outputs/parallel/output/parallel_table.txt.gz"


   TEMP_DIR="$REDI_FOLDER/$FILE-outputs/parallel/temp/"


   COVERAGE_FILE="$REDI_FOLDER/$FILE-outputs/parallel/coverage/$FILE.sorted.STAR.Ev104.cufflinks.cov"


   COVERAGE_DIR="$REDI_FOLDER/$FILE-outputs/parallel/coverage/"


   ./extract_coverage.sh $SOURCE_BAM_FILE $COVERAGE_DIR $SIZE_FILE


   mpirun -np $NUM_CORES src/cineca/parallel_reditools.py -f $SOURCE_BAM_FILE -o $OUTPUT_FILE -r $REFERENCE -t $TEMP_DIR -Z $SIZE_FILE -G $COVERAGE_FILE -D $COVERAGE_DIR


   ./merge.sh $TEMP_DIR $OUTPUT_FILE $NUM_CORES


done






