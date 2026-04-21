FROM quay.io/jupyter/pyspark-notebook:spark-4.1.1

USER root

RUN mkdir -p /opt/jars && \
    wget -q -O /opt/jars/postgresql-42.7.3.jar \
        https://jdbc.postgresql.org/download/postgresql-42.7.3.jar

RUN pip install --no-cache-dir clickhouse-connect==0.7.16 psycopg2-binary

USER ${NB_UID}
