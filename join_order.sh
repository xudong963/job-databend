#!/usr/bin/env bash
. env.sh
QUERY_DIR="queries"
RESULT_DIR="results_with_accurate_his"

if [ ! -d "$QUERY_DIR" ]; then
  echo "$QUERY_DIR does not exist"
  exit 1
fi

mkdir -p "$RESULT_DIR"

query "use imdb"

for query_file in $(ls "$QUERY_DIR"/*.sql | sort); do
  if [ -f "$query_file" ]; then
    echo "Running: $query_file"

    filename=$(basename "$query_file")
    output_file="$RESULT_DIR/${filename%.sql}_result.txt"

    running_sql=$(cat "$query_file")
    query "explain join $running_sql" > "$output_file"

    echo "Result saved to: $output_file"
  fi
done

echo "All queries executed. Results saved in $RESULT_DIR directory."