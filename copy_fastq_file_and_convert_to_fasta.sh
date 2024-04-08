#!/bin/bash

main_folder="/path/to/the/main/folder"  # Replace with the path to your main folder
new_directory="/path/to/the/new/directory"  # Replace with the path to the new directory
counter=01

# Create the new directory if it doesn't exist
mkdir -p "$new_directory"

for folder in $(find "$main_folder" -type d); do
    for file in "$folder"/*; do
        if [ -f "$file" ]; then
            extension="fastq.gz"  # setthe file extension
            new_filename="$new_directory/BC$(printf '%02d' $counter).$extension"  # Create the new filename
            
            # Copy and rename the file to the new directory
            cp "$file" "$new_filename"
            
            ((counter++))  # Increment the counter for the next file
        fi
    done
done

# Convert all FASTQ files in the new directory to FASTA format
for file in "$new_directory"/*.fastq.gz; do
    seqtk seq -A "$file" > "${file%.fastq.gz}.fasta"
done

