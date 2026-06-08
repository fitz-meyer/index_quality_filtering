#/bin/sh
#Date: 2/03/26
#Author: Emily Fitzmeyer

# before running:
# - this script, index_quality_filtering.R, and all fastq files must be in your working directory
# - all R packages (tidyverse, Biostrings, ShortRead) must be installed in R conda environment (R_env)
# - R_env must be activated 
# - BBmap must be installed via conda (bbmap_env)


fqdir=...
for i1 in `ls *_I1_001.fastq.gz`; do
    i2=${i1/_I1_001.fastq.gz/_I2_001.fastq.gz}
    r1=${i1/_I1_001.fastq.gz/_R1_001.fastq.gz}
    r2=${i1/_I1_001.fastq.gz/_R2_001.fastq.gz}
    
    # Generate the output filenames 
   	R1_iFILTERED=${r1/_R1_001.fastq.gz/_R1_ifiltered.fastq.gz}
    R2_iFILTERED=${r2/_R2_001.fastq.gz/_R2_ifiltered.fastq.gz}
        
    if [[ -s $R1_iFILTERED && -s $R2_iFILTERED ]]; then
    	echo "Pair already filtered. Skipping."  
    
    else 
    
    	# Ensure the corresponding R2 file exists
    	if [[ -s $i2 && -s $r1 && -s $r2 ]]; then
        	#echo "Averaging phred for $i1 and $i2"
        	
    			# Pass i1 and i2 variables to R script 
    			R --vanilla -f index_quality_filtering.R --args $i1 $i2
        else
        	#echo "Warning: Corresponding I2, R1, and R2 files not found for $i1"
    	fi
    
    	# Read in low quality reads list
    
    	lowQ="./lowQ_reads.txt"
    
    	if [[ -s $lowQ ]]; then
        	#echo "Low quality reads list successfully generated"
    	else
    		echo "FUCKTANGULAR!"
    	fi
    
    	# Call filterbyname.sh
    
    	conda run -n bbmap_env filterbyname.sh in=$r1 in2=$r2 out=$R1_iFILTERED out2=$R2_iFILTERED names=$lowQ -Xmx900m

    	if [[ -s $R1_iFILTERED && -s $R2_iFILTERED ]] ; then
        	#echo "$i1 pair filtered successfully"
    	else 
    		#echo "Filtering incomplete"
    	fi
    
    fi

done

mkdir ifiltered_fastq
mv *ifiltered.fastq.gz ifiltered_fastq/

rm lowQ_reads.txt

echo "bye"
