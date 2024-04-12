#!/bin/bash

# Check for the correct number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <LaTeX file>"
    exit 1
fi

# Filename without the extension
filename=$(basename -- "$1")
filename="${filename%.*}"

echo "Extracting TikZ figures from ${filename}.tex"

# Counter for TikZ figure files
counter=1

# Flag to indicate if currently processing a TikZ environment
inside_tikz=0

# Process the LaTeX file
while IFS= read -r line; do
    # Check if entering a TikZ picture environment
    if [[ $line == *\\begin{tikzpicture}* ]]; then
        inside_tikz=1
        tikz_filename="${filename}_tikz_${counter}.tex"
        echo "Extracting TikZ figure to $tikz_filename"
        
        # Start a new TikZ figure file with the necessary LaTeX preamble
        cat > "$tikz_filename" <<EOF
\\documentclass[tikz,border=2mm]{standalone}
\\usepackage{tikz}
\\begin{document}
EOF
        echo "$line" >> "$tikz_filename"
    elif [[ $line == *\\end{tikzpicture}* ]]; then
        # Append the line to the current TikZ file and close the environment
        echo "$line" >> "$tikz_filename"
        echo "\\end{document}" >> "$tikz_filename"
        
        inside_tikz=0
        ((counter++))
    elif [ "$inside_tikz" -eq 1 ]; then
        # If currently inside a TikZ environment, append the line
        echo "$line" >> "$tikz_filename"
    fi
done < "$1"