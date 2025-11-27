#!/bin/bash

# Compile script for manuscript, report, and slides
# Usage: ./compile.sh [manuscript|report|slides]
# Automatically detects ctex usage and selects pdflatex or xelatex accordingly

# Function to detect if ctex is used (not commented out)
# Checks both the main tex file and any included preamble files
detect_ctex() {
    local tex_file=$1
    local tex_dir=$(dirname "$tex_file")
    
    # Check main tex file for uncommented \usepackage{ctex} or \RequirePackage{ctex}
    if grep -E '^[^%]*\\(usepackage|RequirePackage)[^}]*\{ctex\}' "$tex_file" > /dev/null 2>&1; then
        return 0  # ctex found
    fi
    
    # Check preamble files that might be included
    if grep -qE '\\(input|include)\{.*preamble' "$tex_file" > /dev/null 2>&1; then
        local preamble_files=$(grep -oE '\\(input|include)\{[^}]+\}' "$tex_file" | sed 's/.*{//;s/}//' | sed "s|^\.\./||" | sed "s|^\./||")
        for preamble in $preamble_files; do
            for check_path in "$tex_dir/$preamble" "$tex_dir/../$preamble"; do
                if [ -f "$check_path" ]; then
                    if grep -E '^[^%]*\\(usepackage|RequirePackage)[^}]*\{ctex\}' "$check_path" > /dev/null 2>&1; then
                        return 0  # ctex found
                    fi
                fi
            done
        done
    fi
    
    return 1  # ctex not found
}

# Function to compile a LaTeX document
compile_doc() {
    local doc_type=$1
    local mv_pdf=$2
    local tex_file="${doc_type}.tex"
    
    echo "Compiling ${doc_type}..."
    cd "$doc_type" || exit 1
    
    # Determine compiler
    if detect_ctex "$tex_file"; then
        COMPILER="xelatex"
        echo "Detected ctex usage - using xelatex"
    else
        COMPILER="pdflatex"
        echo "No ctex detected - using pdflatex"
    fi
    
    # Compilation sequence: pdflatex -> bibtex -> pdflatex -> pdflatex
    $COMPILER -interaction=nonstopmode "$tex_file"
    bibtex "${doc_type}"
    $COMPILER -interaction=nonstopmode "$tex_file"
    $COMPILER -interaction=nonstopmode "$tex_file"
    
    # Move output to outputs directory with timestamp
    TIMESTAMP=$(date +%Y%m%d)
     # Capitalize first letter for display
    DOC_NAME=$(echo "$doc_type" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

    if [ "$mv_pdf" == "notmove" ]; then
        echo "Not moving PDF to outputs directory"
        echo "${DOC_NAME} compiled successfully: ${doc_type}/${doc_type}.pdf"
    elif [ "$mv_pdf" == "move" ]; then
        echo "Moving PDF to outputs directory"
        mv "${doc_type}.pdf" "../outputs/${doc_type}_${TIMESTAMP}.pdf"
        echo "${DOC_NAME} compiled successfully: outputs/${doc_type}_${TIMESTAMP}.pdf"
    else
        echo "Error: Unknown move option '$mv_pdf'"
        echo "Usage: $0 [manuscript|report|slides] [notmove|move]"
        echo "Default behavior: not moving PDF to outputs directory"
    fi
    
    cd ..
}

# Main script
if [ $# -eq 0 ]; then
    echo "Usage: $0 [manuscript|report|slides]"
    echo "Please specify which document to compile."
    exit 1
fi

DOC_TYPE=$1
MOVE_PDF=${2:-notmove}

case $DOC_TYPE in
    manuscript|report|slides)
        compile_doc "$DOC_TYPE" "$MOVE_PDF"
        ;;
    *)
        echo "Error: Unknown document type '$DOC_TYPE'"
        echo "Usage: $0 [manuscript|report|slides]"
        exit 1
        ;;
esac
