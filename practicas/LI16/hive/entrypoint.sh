#!/bin/bash
set -e
export JAVA_HOME=/usr/local/openjdk-11
export HADOOP_HOME=/opt/hadoop-3.3.6
export HADOOP_CONF_DIR=/etc/hadoop
export HIVE_HOME=/opt/hive
export PATH="${JAVA_HOME}/bin:${HADOOP_HOME}/bin:${HIVE_HOME}/bin:${PATH}"

if [ ! -d "${HIVE_HOME}/metastore_db" ]; then
  echo "Inicializando el metastore Derby de Hive ${HIVE_VERSION:-4.0.1}"
  schematool -dbType derby -initSchema
fi

echo "hive-server listo. Warehouse HDFS: /user/hive/warehouse"
exec sleep infinity
