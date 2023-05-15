# This should be run after running parallel_REDItools2.0.sh
# Use the same folder as REDI_FOLDER in that script
import pandas as pd
import os
import gzip

compare_to_snps = False
# filter table to only loci with substitutions
REDI_FOLDER = "/mnt/iquityazurefileshare1/Test/MiniTestData_HCvMN/redioutput"

folders = os.listdir(REDI_FOLDER)

for folder_name in folders:
    dir_name = "%s/%s/parallel/output" % (REDI_FOLDER, folder_name)
    if folder_name.endswith('-outputs'):
        file_name = folder_name[:-8]
    if file_name.endswith('_seq'):
        file_name = file_name[:-4]
    outfile = open(
        '%s/parallel_table_filtered.txt' % (dir_name), "w")
    print("Reading parallel table output from REDItools...")
    print(dir_name)
    with gzip.open("%s/parallel_table.txt.gz" % (dir_name)) as f:
        for line in f:
            if line.split("\t")[7] != "-":
                if line.split("\t")[0] in [str(i+1) for i in range(22)]:
                    outfile.write("chr" + line)
                else:
                    outfile.write(line)
    outfile.close()
