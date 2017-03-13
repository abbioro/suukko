all: build

build:
	./blog.sh

serve:
	echo "Starting server at http://127.0.0.1:8000/"
	python2 -m SimpleHTTPServer

clean:
	rm -f index.html about.html
	find ./ -mindepth 3 -name "*.html" -exec rm -f {} \;
