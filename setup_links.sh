#!/bin/bash 

# Different device has its own path settings for symlinking the above folders
# Modify taret_root to match your OneDrive path on your device
# This script creates symlinks for large files/folders that should be synced via OneDrive:
# - figcodes/data: large data files
# - figcodes/figs: large number of images
# - outputs: final reports, slides, and papers

taret_root="$HOME/OneDrive/OneDrive - The Chinese University of Hong Kong/Documents/manuscripts/proj-doc-template"
links=("figcodes/data" "figcodes/figs" "outputs")

for lk in ${links[@]}; do
    # Remove existing directory/file if it exists and is not a symlink
    if [ -e "$lk" ] && [ ! -L "$lk" ]; then
        echo "Removing existing directory: $lk"
        rm -rf "$lk"
    fi
    
    # Create symlink
    echo "Creating symlink: $lk -> $taret_root/$lk"
    mkdir -p "$(dirname "$lk")"
    ln -sf "$taret_root/$lk" "$lk"
done

echo "Symlinks created successfully!"
