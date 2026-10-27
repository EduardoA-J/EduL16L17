FROM hadoop-base:3.3.6

USER root

ENV HIVE_VERSION=4.0.1
ENV HIVE_HOME=/opt/hive
ENV HADOOP_HOME=/opt/hadoop-3.3.6
ENV JAVA_HOME=/usr/local/openjdk-11
ENV PATH=$JAVA_HOME/bin:$HIVE_HOME/bin:$HADOOP_HOME/bin:$PATH

RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/* \
    && curl -fSL "https://archive.apache.org/dist/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz" -o /tmp/hive.tar.gz \
    && tar -xzf /tmp/hive.tar.gz -C /opt \
    && mv /opt/apache-hive-${HIVE_VERSION}-bin ${HIVE_HOME} \
    && rm -f /tmp/hive.tar.gz \
    && rm -f ${HIVE_HOME}/lib/guava-*.jar \
    && cp ${HADOOP_HOME}/share/hadoop/common/lib/guava-*.jar ${HIVE_HOME}/lib/ \
    && if [ -f ${HIVE_HOME}/conf/hive-log4j2.properties.template ]; then \
         cp ${HIVE_HOME}/conf/hive-log4j2.properties.template ${HIVE_HOME}/conf/hive-log4j2.properties; \
         sed -i 's/property.hive.log.level = INFO/property.hive.log.level = WARN/' ${HIVE_HOME}/conf/hive-log4j2.properties; \
       fi

COPY hive-site.xml ${HIVE_HOME}/conf/hive-site.xml
COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh && chmod a+x /entrypoint.sh

EXPOSE 10000 10002 9083

CMD ["/entrypoint.sh"]
