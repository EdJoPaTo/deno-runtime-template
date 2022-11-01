#!/usr/bin/env bash
set -eu

# Usage
# Go to the project you want to improve via this template
# cd ~/git/my-project
# Run this script from the working directory of that project
# ~/git/deno-runtime-template/copy-template-into-existing-project.sh

name=$(basename "$PWD")
templatedir="$(dirname "$0")"

cp -r \
	"$templatedir/"{.github,.gitignore,.dockerignore,Dockerfile,LICENSE,deno.jsonc} \
	.

echo "everything copied"

# Replace template name with folder name
# macOS: add '' after -i like this: sed -i '' "s/…
sed -i "s/deno-runtime-template/$name/g" Dockerfile

git --no-pager status --short
