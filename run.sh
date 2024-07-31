#!/usr/bin/env bash
. env.sh
QUERY_DIR="queries"
OUTPUT_FILE="execution_times.log"

if [ ! -d "$QUERY_DIR" ]; then
  echo "$QUERY_DIR does not exist"
  exit 1
fi

query "use imdb"

: > "$OUTPUT_FILE"

total_start_time=$(date +%s)

for query_file in $(ls "$QUERY_DIR"/*.sql | sort); do
  if [ -f "$query_file" ]; then
    echo "Running: $query_file"

    start_time=$(date +%s)
    running_sql=$(cat "$query_file")
    query "$running_sql"

    end_time=$(date +%s)

    duration=$((end_time - start_time))

    echo "time: $duration s"
    echo "$query_file: $duration s" >> "$OUTPUT_FILE"
  fi
done

total_end_time=$(date +%s)

total_duration=$((total_end_time - total_start_time))

echo "Total time: $total_duration s"
echo "Total time: $total_duration s" >> "$OUTPUT_FILE"