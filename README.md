       RNA Editing
Running REDItools2.0 (parallel)
# RNA Editing
REDItools are python scripts developed with the aim to study RNA editing at genomic scale by next generation sequencing data. RNA editing is a post-transcriptional phenomenon involving the insertion/deletion or substitution of specific bases in precise RNA localizations.
## Prerequisite
REDItools require python 2.7 (available at the official python web-site) while python 3 is not yet supported. In addition, REDItools need two external modules:

pysam (mandatory) version >= 0.15 available here
fisher (optional) version 0.1.4 (optional) available at python web site
To perform Blat correction and format alignment exchanges (SAM to BAM and vice versa) the following packages should be installed or already present in your path:

Blat package including gfServer and gfClient executables or pblat
Samtools and tabix

## Running REDItools2.0 
## Environment set-up
### Create a virtual environment 
source ENV/bin/activate

1. Environment set-up
Make a virtual environment with python 2.7 and ensure that REDItools was installed properly as shown here: 
The detail installation steps are included in Reditools readme tutorial in this link.
https://github.com/BioinfoUNIBA/REDItools/blob/master/README_1.md

git clone https://github.com/BioinfoUNIBA/REDItools
cd REDItools
python setup.py install

2. Running REDItools 2.0
First, we need to upload  Clone the github repository for REDItools.
git clone https://github.com/BioinfoUNIBA/REDItools
Navigate to this repo.
cd REDItools
python setup.py install
Choose which samples to run and edit the script parallel_REDItools2.0.sh. Run from the REDItools github repo folder. 
This will generate tables for each sample of possible RNA editing sites in a directory for each sample as parallel_table.txt.gz. In other words, for each sample you will have the directory and  inside each individual sample folder, your output files are stored.

### Filtering and processing data
 
 Next step is to filter data, to include only edited sites by dropping  invariant sites by running script:
 python2.7 RES_main.py

I updated a chromosomal regions from  "1" to  "chr1".  Once you run this step, you will have parallel_table_filtered.txt fiiles in each sample folder.

4. 
 


