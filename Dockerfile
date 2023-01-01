FROM docker.io/denoland/deno:1.29.1
RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends bash \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /var/cache/* /var/log/*

WORKDIR /app

COPY deno.jsonc *.ts ./
RUN deno cache *.ts

COPY . ./

CMD deno run deno-runtime-template.ts
