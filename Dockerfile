FROM pgvector/pgvector:pg14

RUN apt-get update && \
            apt-mark hold locales && \
            apt-get install -y --no-install-recommends build-essential postgresql-server-dev-14

COPY . /tmp/pg_quota
RUN cd /tmp/pg_quota
RUN make -f /tmp/pg_quota/Makefile install

RUN mkdir /usr/share/doc/pg_quota && \
            cp LICENSE README.md SECURITY.md VERSiON /usr/share/doc/pg_quota && \
            rm -r /tmp/pg_quota && \
            apt-get remove -y build-essential postgresql-server-dev-$PG_MAJOR && \
            apt-get autoremove -y && \
            apt-mark unhold locales && \
            rm -rf /var/lib/apt/lists/*    