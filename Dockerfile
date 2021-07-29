FROM archlinux:latest as builder

WORKDIR /build

RUN pacman -Sy curl tar --noconfirm

RUN curl -sSL https://dl.mumble.info/latest/stable/server-linux-x86 | tar xj --strip 1

FROM archlinux:latest
LABEL maintainer='GenericEric'
RUN groupadd -r murmur
RUN useradd -r -g murmur -m -d /var/lib/murmur -s /sbin/nologin murmur
COPY --from=builder /build/murmur.ini /templates/murmur.ini
COPY --from=builder /build/murmur.x86 /usr/local/bin/murmur
COPY ./start.sh /usr/local/bin/murmur-wrapper
RUN chmod +x /usr/local/bin/murmur-wrapper

RUN mkdir -m770 /data
RUN chown 65521 /data

VOLUME /data

EXPOSE 64738/tcp
EXPOSE 64738/udp

USER 65521

ENTRYPOINT ["/usr/local/bin/murmur-wrapper"]