FROM docker.io/denoland/deno:latest AS builder
RUN apt-get update \
	&& apt-get upgrade -y
WORKDIR /app
COPY . ./
RUN deno compile \
	deno-runtime-template.ts


FROM docker.io/library/debian:trixie-slim AS final
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends bash \
	&& apt-get clean \
	&& groupadd --system --gid 923 runner \
	&& useradd --system --uid 923 --gid 923 --create-home runner \
	&& rm -rf /etc/*- /var/lib/apt/lists/* /var/cache/* /var/log/*

WORKDIR /app

COPY --from=builder /app/deno-runtime-template /usr/local/bin/

USER runner
CMD ["deno-runtime-template"]
