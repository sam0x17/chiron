# Chiron

Chiron is a tool for developing and deploying static websites using HTML / CSS / JavaScript
and deploying them to CloudFront/S3 via [Apex's Up tool](https://apex.sh/docs/up).
Because Chiron is written in the [Crystal programming language](https://crystal-lang.org),
it is faster than most local development web servers and deployment pipelines, and is designed
as an all-around, zero-dependency replacement for the Webpack / Node.js / NPM ecosystem when it
comes to developing, compiling and deploying static websites.

Chiron relies on Crystal ports of [clean-css](https://github.com/jakubpawlowicz/clean-css),
[uglify-js](https://github.com/mishoo/UglifyJS2), [html-minifier](https://github.com/kangax/html-minifier),
and [LESS](http://lesscss.org/) (that are embedded via [duktape.cr](https://github.com/jessedoyle/duktape.cr)),
providing **a full pipeline of HTML / CSS / JavaScript minification, basic templating, LESS support, and deployment to CloudFront/S3 without the need for any Webpack, Node.js or NPM dependencies**. The only
external dependency for Chiron is Up which is written in Go and similarly available via a
cross-platform binary distribution.

Chiron is intended to be paired with a separate API server to facilitate dynamic behavior,
or to be used to create fully static websites.

The `chiron` binary allows for the creation (and updating) of projects, and provides
a super-fast local development server based on [kemal](https://kemalcr.com/). All Chiron
projects are valid Up projects, and deployment is intended to be done using the standard
[mechanisms provided by Up](https://apex.sh/docs/up/commands/#deploy).

## Installation

TODO: Write installation instructions here

## Usage

TODO: Write usage instructions here
