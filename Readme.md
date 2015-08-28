## presentations

A repository of presentations using [reveal.js](https://github.com/hakimel/reveal.js/) and [Docker](https://docker.com)

## quickstart

To run one of the presentations - first clone this repo and then use the `run.sh` script passing the name of the presentation as the first argument:

```bash
$ git clone https://github.com/binocarlos/presentations
$ cd presentations
$ bash run.sh docker-plugins
```

Docker will expose port 80 on the host so you should be able to hit `http://localhost` to see the presentation.  If you are running inside a VM (either using Vagrant or something else) - you need to expose port 80 inside the VM onto your laptop.

Each presentation lives in a folder inside the repo.  Each slide is a markdown file converted into HTML by reveal.js

## usage

To make a presentation - put the markdown slides into its own folder - for example `powerstrip-weave` is a presentation with `slide1.md` etc.

There is an `index.html` file for each presentation that controls the loading of each slide.

Each slide is a `section` a follows:

```html
<section data-markdown="slides/slide1.md"  
   data-separator="^\n\n\n"  
   data-separator-vertical="^\n\n"  
   data-separator-notes="^Note:"  
   data-charset="iso-8859-15">
</section>
```

To include an image on a slide - you point at the `slides/images` folder - in the case of the `powerstrip-weave` presentation, this is mapped to `powerstrip-weave/images`:

```
![weave run](slides/images/ps-weave.png "weave run")
```

To trigger syntax highlighting - the first slide must be non-html (a PR would be great to fix this!).

For example - the first slide of the `powerstrip-weave` presentation is:

```html
<section>
  <h3>powerstrip-weave</h3>
  <p>
    <small>extending docker with powerstrip adapters</small>
  </p>
  <p>
  <pre><code>
if(powerstrip){

// I can haz multiple extensions?
var adapters = ["flocker", "weave"];
docker.extend(adapters);

}
  </code></pre>
  </p>
</section>
```

Every other slide can then be markdown with code snippets that will syntax highlighted.

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
    -v /srv/projects/presentations/$presentation/index.html:/app/reveal.js/index.html \
    -v /srv/projects/presentations/$presentation:/app/reveal.js/slides \
    -v /srv/projects/presentations/$presentation/images:/app/reveal.js/images \
  binocarlos/presentations
```

## view presentation

Once you have started the presentation - you can view it by connecting the the IP address of your dockerhost on port 80

## licence

Copyright 2015 Kai Davenport & Contributors

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License.  You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the License for the specific language governing permissions and limitations under the License.