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

### A third-level heading

1. Environment set-up
Make a virtual environment with python 2.7 and ensure that REDItools was installed properly as shown here: https://github.com/BioinfoUNIBA/REDItools2#4-insta
