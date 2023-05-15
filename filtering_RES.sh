#!/bin/bash

REDI_FOLDER="/mnt/iquityazurefileshare1/Test/MiniTestData_HCvMN/redioutput"
REF_FILES="/mnt/iquityazurefileshare1/Test/MiniTestData_HCvMN/rna_editing/reference"

REDI_REPO="/mnt/iquityazurefileshare1/Test/MiniTestData_HCvMN/rna_editing/accessory"

#for RefSeq annotations:
#Download refGene.txt.gz for appropriate genome build, then
# gunzip refGene.txt.gz
# Download genPredToGtf: http://hgdownload.soe.ucsc.edu/admin/exe/ 
# make executable: chmod +x ./filePath/utility_name
# cut -f 2- refGene.txt | ./genePredToGtf -utr -source=hg19_refseq file stdin refGene.gtf
# sort -k1,1 -k4,4n refGene.gtf > refGene.sorted.gtf

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

for FILE in    $FILE1 $FILE2 $FILE3 $FILE4 $FILE5 $FILE10 # $FILE6 $FILE7 $FILE8 $FILE9
do
    echo "$FILE"
    FOLDER="$REDI_FOLDER/$FILE-outputs/parallel/output"
    FILTERED_TABLE="$FOLDER/parallel_table_filtered.txt"
    CANDIDATES_NAME="$FOLDER/candidates.txt"
    RMSK_NAME="$FOLDER/candidates.rmsk.txt"
    RMSK_ALU_NAME="$FOLDER/candidates.rmsk.alu.txt"
    RMSK_ALU_ANNOT_NAME="$FOLDER/candidates.rmsk.alu.ann.txt"
    python2.7 $REDI_REPO/selectPositions.py -i $FILTERED_TABLE -c 2 -v 2 -f 0.1 -e -o $CANDIDATES_NAME
    python2.7 $REDI_REPO/AnnotateTable.py -a $REF_FILES/rmsk.gtf.gz -i $CANDIDATES_NAME -u -c 1,2,3 -n RepMask -o $RMSK_NAME
    python2.7 $REDI_REPO/FilterTable.py -i $RMSK_NAME -f $REF_FILES/rmsk.gtf.gz -F SINE -E -o $RMSK_ALU_NAME -p

    #note: when running this for the first time, you may need to use refGene.sorted.gtf from above; the gzipped version will be created.
    python2.7 $REDI_REPO/AnnotateTable.py -a $REF_FILES/refGene.sorted.gtf.gz -i $RMSK_ALU_NAME -u -c 1,2 -n RefSeq -o $RMSK_ALU_ANNOT_NAME

done
