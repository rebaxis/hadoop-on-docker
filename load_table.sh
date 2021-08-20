#!/bin/bash

while /opt/hive/bin/beeline -u jdbc:hive2://localhost:10000 -e "show databases;" ; ret=$? ; [ $ret -ne 0 ]; do
    echo 'fail beeline connection'
    sleep 10
done

/opt/hive/bin/beeline -u jdbc:hive2://localhost:10000 -e "CREATE TABLE pokes (foo INT, bar STRING); LOAD DATA LOCAL INPATH '/opt/hive/examples/files/kv1.txt' OVERWRITE INTO TABLE pokes;"

