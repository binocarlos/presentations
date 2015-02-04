#!/bin/bash

cmd-present(){
  local presentation="$1";
  if [[ ! -d ./$presentation ]]; then
    echo "$presentation folder not found";
    exit 1;
  fi
  docker run -d \
    -p 80:8000 \
    --name presenter \
    -v /srv/projects/presentations/$presentation/index.html:/app/reveal.js/index.html \
    -v /srv/projects/presentations/$presentation:/app/reveal.js/slides \
    -v /srv/projects/presentations/$presentation/images:/app/reveal.js/images \
    binocarlos/presentations
}

main() {
  case "$1" in
  *)                  cmd-present $@;;
  esac
}

main "$@"
