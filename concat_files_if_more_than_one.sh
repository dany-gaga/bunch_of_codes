#!/bin/bash 
# dany


main_folder="/path/to/the/main/folder" #replace with path


for folder in $(find $main_folder -type d); do # this iterates through the main folder
	num_files=$(find $folder -maxdepth 1 -type f | wc -l) # here the numer of files is counted with (f) excluding anydirectories if any (-maxdepth 1) then use the count (wc) to count the number of lines with (l)
	if [ $num_files -gt 1 ]; then # here if the sum pf num files is greater (-gt) than 1 it concatenates the files in the subfolder
		concatenated_data=""
		output_file="$folder/concat.fastq.gz"  # Define unique output file for each subfolder
		
		for file in $folder/*; do 
			if [ -f "$file" ]; then 
				cat "$file" >> "$output_file"  # Use >> to append to the output file
				rm "$file"  # Remove the original file after concatenation
			fi 
		done
	fi
done


