#!/usr/bin/env bash
. env.sh

stmt "drop stage if exists s1"
stmt "create stage s1 url='fs://${PWD}/data/'"

stmt "select 1"

# insert data to tables
for t in aka_name aka_title cast_info char_name comp_cast_type company_name company_type complete_cast info_type keyword kind_type link_type movie_companies movie_info movie_info_idx movie_keyword movie_link name person_info role_type title; do
    echo "$t"
    sub_path="$t.csv"
   	query "copy into imdb.$t from @s1/${sub_path} file_format = (type = CSV, escape='\\\\\\\\')"
done