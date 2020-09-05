#!/bin/bash -x

docker rm -f jekyllserver
docker build -t jekyllboby .

docker run --rm --volume="$PWD:/srv/jekyll" -it jekyllboby jekyll build

docker run --name jekyllserver --volume="$PWD:/srv/jekyll" -p 4000:4000 -it jekyllboby jekyll serve --watch --drafts
