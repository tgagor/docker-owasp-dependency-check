FROM openjdk:11
MAINTAINER TiMoR <timor.site>

ARG DEPENDENCY_CHECK_VERSION=6.0.4
RUN curl -fsSLo /tmp/dependency-check.zip https://github.com/jeremylong/DependencyCheck/releases/download/v${DEPENDENCY_CHECK_VERSION}/dependency-check-${DEPENDENCY_CHECK_VERSION}-release.zip && \
    curl -fsSLo /tmp/dependency-check.zip.asc https://github.com/jeremylong/DependencyCheck/releases/download/v${DEPENDENCY_CHECK_VERSION}/dependency-check-${DEPENDENCY_CHECK_VERSION}-release.zip.asc && \
    gpg --batch --keyserver hkp://keys.gnupg.net --recv-keys F9514E84AE3708288374BBBE097586CFEA37F9A6 && \
    gpg --batch --verify /tmp/dependency-check.zip.asc /tmp/dependency-check.zip && \
    unzip /tmp/dependency-check.zip -d /opt && \
    rm -f /tmp/dependency-check.* && \
    ln -s /opt/dependency-check/bin/dependency-check.sh /usr/local/bin/dependency-check && \
    mkdir -p /code && \
    mkdir -p /report && \
    chown -R 10000:10000 /report

# build cache of NVD/CVE updates
RUN dependency-check --updateonly

VOLUME [ "/code", "/report" ]

ENTRYPOINT [ "/usr/local/bin/dependency-check" ]
CMD ["--format", "HTML", "--project", "dummy", "--scan", "/code", "--out", "/report"]
