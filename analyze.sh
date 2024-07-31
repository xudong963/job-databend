#!/usr/bin/env bash
. env.sh

# analyze tables
for t in aka_name aka_title cast_info char_name comp_cast_type company_name company_type complete_cast info_type keyword kind_type link_type movie_companies movie_info movie_info_idx movie_keyword movie_link name person_info role_type title; do
    echo "$t"
   	query "set enable_analyze_histogram = 1; analyze table imdb.$t"
done