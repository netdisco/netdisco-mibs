FROM alpine:latest

RUN apk add --no-cache \
        bash \
        ca-certificates \
        coreutils \
        curl \
        diffutils \
        findutils \
        git \
        git-lfs \
        grep \
        gzip \
        net-snmp-tools \
        openssh-client \
        perl \
        perl-file-slurper \
        perl-try-tiny \
        tar \
        unzip \
        xz

# If a writable host mount is necessary, build with the invoking user's
# UID/GID. Matching ownership does not isolate configuration or hooks.
ARG MIBDEV_UID=1000
ARG MIBDEV_GID=1000

RUN addgroup -g "$MIBDEV_GID" mibdev \
    && adduser -D -u "$MIBDEV_UID" -G mibdev -s /bin/bash mibdev \
    && mkdir /workspace \
    && chown mibdev:mibdev /workspace

USER mibdev
WORKDIR /workspace

ENV MIBHOME=/workspace/netdisco-mibs

# These settings affect only the container user's Git configuration.
RUN git config --global core.autocrlf input \
    && git config --global push.default current \
    && git config --global core.whitespace cr-at-eol \
    && git config --global diff.lfs.textconv cat \
    && git lfs install --skip-repo

# Fail the build if required tools or Perl modules are unavailable.
RUN git lfs version \
    && snmpstatus --version 2>&1 | grep -E '5\.9\.' \
    && perl -MFile::Slurper -MTry::Tiny \
            -MTerm::ANSIColor -MTime::HiRes -e 1

CMD ["/bin/bash"]
