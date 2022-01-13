#!/bin/bash

function sed_quote_lines_escape_single_quotes
{
	sed -e "s/'/'\\\\''/g;s/\(.*\)/'\1'/"
}

function get_file_list_for_ffmpeg
{
	dir="$1"; shift

	find "$dir" -mindepth 1 -type f \
		| sort \
		| sed_quote_lines_escape_single_quotes \
		| sed 's/^/file /'
}

get_file_list_for_ffmpeg './input'
