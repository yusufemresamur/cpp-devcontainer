#!/usr/bin/env bash

files=( "$HOME/.netrc" "$HOME/.gitconfig" )
directories=( "$HOME/.cache" )


# Create files
for file in "${files[@]}"; do
    if [ ! -f "$file" ]; then
        touch "${file}"
        echo "Created file '${file}'"
    else
        echo "File '${file}' already exists."
    fi
done

# Create directories
for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "${dir}"
        echo "Created directory '${dir}'"
    else
        echo "Directory '${dir}' already exists."
    fi
done