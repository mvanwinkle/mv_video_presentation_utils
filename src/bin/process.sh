#!/bin/bash

# ffmpeg -f concat -safe 0 -i my_list.txt -c copy output.mkv
# https://trac.ffmpeg.org/wiki/Concatenate
# The -safe 0 above is not required if the paths are relative.
# apparently you need to use -safe 0 if you're doing process substitution
# ffmpeg -i abstract1.mkv abstract1.mp4

input_file="$1" ; shift
output_directory="$1"; shift
output_format="$1"; shift;
output_label="$1" ; shift

if [[ ! -e "$input_file" ]]
then
	>&2 echo "First argument is input file."
	exit 1
fi

if [[ ! -d "$output_directory" ]]
then
	>&2 echo "Second argument is output directory."
	exit 1
fi

if [[ -z "$output_format" ]]
then
	>&2 echo "Third argument is output format."
	exit 1
fi

if [[ -z "$output_label" ]]
then
	output_label="unlabeled"
fi


timestamp=$( date +'%Y-%m-%d-%H-%M-%S' )

output_file="${output_directory}/${timestamp}__${output_label}.${output_format}"

ffmpeg -f concat -safe 0 -i "$input_file" -c copy "$output_file"
