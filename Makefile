.PHONY : all coq html website clean

all: coq html website

html:
	$(MAKE) -C coq html

coq:
	$(MAKE) -C coq

website:
	$(MAKE) -C coq html
	mv coq/html/*html website
	rm -rf coq/html

clean:
	$(MAKE) -C coq clean
	rm -f website/*html

count:
	coqwc coq/*.v

push: website
	rsync -v website/*.html forster@james.ps.uni-saarland.de:~/public_html/undecidability/

pdf:
	cd tex && latexmk paper.tex
	rsync -v tex/paper.pdf forster@james.ps.uni-saarland.de:~/public_html/downloads/certified-undecidability-of-ill.pdf
