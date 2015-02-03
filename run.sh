#!/bin/bash

cmd-present(){
  local presentation="$1";
  docker run -d \
    -p 80:8000 \
    --name presenter \
    -v /srv/projects/presentations/$presentation/index.html:/app/reveal.js/index.html \
    -v /srv/projects/presentations/$presentation:/app/reveal.js/slides \
    binocarlos/presentations
}

main() {
  case "$1" in
  *)                  cmd-present $@;;
  esac
}

main "$@"
