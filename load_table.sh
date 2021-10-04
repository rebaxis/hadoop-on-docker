#!/bin/bash

while /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000 -e "show databases;" ; ret=$? ; [ $ret -ne 0 ]; do
    echo 'fail beeline connection'
    sleep 10
done

while /opt/hadoop/bin/hdfs dfs -ls hdfs://namenode:8020/ ; ret=$? ; [ $ret -ne 0 ]; do
    echo 'fail hdfs connection'
    sleep 10
done

/opt/hive/bin/beeline -u jdbc:hive2://localhost:10000 -e "CREATE TABLE pokes (foo INT, bar STRING) LOCATION 'hdfs://namenode:8020/tmp/pokes';" -e "LOAD DATA LOCAL INPATH '/opt/hive/examples/files/kv1.txt' OVERWRITE INTO TABLE pokes;"

