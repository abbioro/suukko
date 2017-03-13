#!/usr/bin/env bash
# Copyright (c) 2017 Joonatan O'Rourke
# Static blog generator written in bash.

MARKDOWN=markdown

shopt -s globstar

# The title is the first line in the post. Strip the first two
# characters to only give us the name.
get_title() {
    title=$(sed -n 1p "$1")
    echo -n ${title:2}
}

# The title is the second line in the post. Strip all asterisks
# (emphasis markers).
get_date() {
    date=$(sed -n 2p "$1")
    echo -n $(echo $date | sed 's/\*//g')
}

# Sets the title of the page. First arg is the filename, second is the
# title.
set_title() {
    sed -i -e "s/TITLE/$2/g" "$1"
}

# Add an index entry for a filename (first arg).
add_index_entry() {
    # Github Pages has ignoring extensions built-in
    noext="$(dirname $filename)/$(basename $filename .html)"
    echo "<div class=\"index-entry\">" >> index.html
    echo "<span>$(get_date $1)</span> -" >> index.html
    echo "<a href=\"$noext\">$(get_title $1)</a>" >> index.html
    echo "</div>" >> index.html
}

# Generate a page for a post. Also appends a link to the index.
generate_page() {
    echo "Generating $1"
    filename=$(echo $1 | sed 's/.md/.html/')
    cat static/header.html > $filename
    $MARKDOWN $1 >> $filename
    cat static/footer.html >> $filename
    set_title $filename "$(get_title $1)"
}

# Generate the blog. The index is generated as it generates the pages
# for individual posts.
generate_blog() {
    cat static/header.html > index.html
    echo "<div class=\"about\">" >> index.html
    $MARKDOWN "about.md" >> index.html
    echo "</div><hr>" >> index.html
    # Only do subdirectories, top-level ones are done
    # manually. Globstar gives us the files in chronological order,
    # but we want them in the opposite order so reverse with ls.
    for post in $(ls -r **/*/*.md); do
        generate_page "$post"
        add_index_entry "$post"
    done
    cat static/footer.html >> index.html
    set_title index.html "John Doe"
}

generate_blog
