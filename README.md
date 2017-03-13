# suukko
Suukko - a KISS static blog generator

## Dependencies

- GNU coreutils (`bash`, `find`, `sed`, `date`, etc.)
- A Markdown implementation (I use Discount)

## Usage

1. Write your "about" page in `about.md`
2. Put your name in `static/header.html`
3. Put any additional links in `static/footer.html`
4. Customize `static/style.css` to your preference
5. Run `make build` or simply `make` to build the site

Blog posts are stored in subdirectories according to date, see the
example in the 2017 directory. Dates are in ISO format.

The index page is both the "about" page and an archive for all your
posts. If you make too many posts it will probably become unmanageable
at some point.

`make clean` will clean up all the HTML files. `make serve` will serve
them up on a local HTTP server, assuming you have Python installed
(remember to add the `.html` extension if you want to view your pages,
since this is designed to be served on a web server with rewriting
enabled).

## Choose Your Markdown

Suukko will use whatever markdown parser you like, just change the
environment variable at the top of `blog.sh`.
