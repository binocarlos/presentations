## presentations

A repository of presentations using [reveal.js](https://github.com/hakimel/reveal.js/)

## install

```bash
$ docker build -t binocarlos/presentations .
```

## usage

To make a presentation - put the markdown slides into its own folder - for example `powerstrip-weave` is a presentation with `slide1.md` etc.

## run server

To run a presentation - you mount the index.html as a volume and the slides folder as a volume.

For example, to run the `powerstrip-weave` presentation:


```bash
$ run.sh powerstrip-weave
```

Which in turn runs this command:

```bash
$ docker run -d \
  -p 80:8000 \
  -v /srv/projects/presentations/powerstrip-weave/index.html:/app/reveal.js/index.html \
  -v /srv/projects/presentations/powerstrip-weave/index.html:/app/reveal.js/index.html \
  binocarlos/presentations
```