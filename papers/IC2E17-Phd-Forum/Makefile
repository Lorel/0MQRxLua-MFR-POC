FIGS=$(wildcard images/*.pdf)
TEXS=$(wildcard *.tex)
PAPER = paper

all:	$(PAPER).pdf

$(PAPER).pdf:	$(TEXS) $(FIGS) biblio.bib
		rubber -d $(PAPER).tex

clean:
	rubber -d --clean $(PAPER).tex
	rm -f $(PAPER).out

.PHONY:	all clean
