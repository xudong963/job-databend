#!/usr/bin/env bash
. env.sh
QUERY_DIR="queries"
RESULT_DIR="results_with_accurate_his"

if [ ! -d "$QUERY_DIR" ]; then
  echo "$QUERY_DIR does not exist"
  exit 1
fi

# 创建结果目录（如果不存在）
mkdir -p "$RESULT_DIR"

query "use imdb"

# 遍历查询文件夹下按文件名排序的所有 SQL 文件
for query_file in $(ls "$QUERY_DIR"/*.sql | sort); do
  if [ -f "$query_file" ]; then
    echo "Running: $query_file"

    # 获取不带路径的文件名
    filename=$(basename "$query_file")
    # 创建对应的输出文件名
    output_file="$RESULT_DIR/${filename%.sql}_result.txt"

    running_sql=$(cat "$query_file")
    # 执行查询并将结果写入文件
    query "explain join $running_sql" > "$output_file"

    echo "Result saved to: $output_file"
  fi
done

echo "All queries executed. Results saved in $RESULT_DIR directory."