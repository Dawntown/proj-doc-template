#!/bin/bash

# Clean script to remove compiled auxiliary files

echo "Cleaning auxiliary files..."

# Clean manuscript directory
if [ -d "manuscript" ]; then
    cd manuscript
    rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz *.bbl *.blg *.run.xml *.bcf *.nav *.snm *.vrb
    cd ..
    echo "Cleaned manuscript directory"
fi

# Clean report directory
if [ -d "report" ]; then
    cd report
    rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz *.bbl *.blg *.run.xml *.bcf *.nav *.snm *.vrb
    cd ..
    echo "Cleaned report directory"
fi

# Clean slides directory
if [ -d "slides" ]; then
    cd slides
    rm -f *.aux *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.synctex.gz *.bbl *.blg *.run.xml *.bcf *.nav *.snm *.vrb
    cd ..
    echo "Cleaned slides directory"
fi

echo "Cleaning complete!"

