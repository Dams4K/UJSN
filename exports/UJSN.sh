#!/bin/sh
echo -ne '\033c\033]0;UJSN\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/UJSN.x86_64" "$@"
