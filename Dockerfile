FROM docker.io/lukechannings/deno:latest AS deno

FROM docker.io/library/debian:bookworm-slim

COPY --from=deno /usr/bin/deno /usr/local/bin/
RUN useradd --uid 1993 --user-group deno \
	&& mkdir -p /deno-dir \
	&& chown deno:deno /deno-dir \
	&& deno --version
ENV DENO_DIR /deno-dir/
ENV DENO_INSTALL_ROOT /usr/local

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends bash \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/cache/* /var/log/*

WORKDIR /app

COPY . ./
RUN deno cache *.ts

CMD ["deno", "run", "deno-runtime-template.ts"]
