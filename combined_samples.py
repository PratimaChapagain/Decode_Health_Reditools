import sys
import os
import pandas as pd

REDI_FOLDER = "/mnt/iquityazurefileshare1/Test/MiniTestData_HCvMN/redioutput"

folders = os.listdir(REDI_FOLDER)
res = pd.DataFrame()
outfile_all = open(
    '%s/all_candidates.txt' % REDI_FOLDER, "w"
)
for folder in folders:
    print(folder)
    try:
        df_path = "%s/%s/parallel/output/candidates.rmsk.alu.ann.txt" % (REDI_FOLDER, folder)
        outfile = open(
            '%s/%s/parallel/output/candidates_alu_annotated.txt' % (REDI_FOLDER, folder), "w")

        with open(df_path, "r") as f:
            for line in f:
                l = line.split('\t')
                outfile.write(str(l[0])+":"+str(l[1])+ "\t" +str(l[7])+"\t"+str(l[8])+"\t"+str(l[17])+"\t"+str(l[18]))
                outfile_all.write(str(folder.split('_')[0])+"\t"+str(l[0])+":"+str(l[1])+ "\t" +str(l[7])+"\t"+str(l[8])+"\t"+str(l[17])+"\t"+str(l[18]))

        outfile.close()
    except NotADirectoryError: continue
outfile_all.close()
