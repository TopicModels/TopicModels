PDF_TARGET = topicmodels.pdf
HTML_TARGET = index.html
TEX_SOURCE = topicmodels.tex
BIB_SOURCE = biblio.bib
FIG_SOURCE = $(wildcard fig/*)

.PHONY : all build pdf html clean

build : pdf html

all : clean build

pdf : $(PDF_TARGET)

html: $(HTML_TARGET)

$(PDF_TARGET) : $(TEX_SOURCE) $(BIB_SOURCE) $(FIG_SOURCE)
	tectonic $<

$(HTML_TARGET) : $(TEX_SOURCE) $(BIB_SOURCE) $(FIG_SOURCE)
	pandoc -s $< -o $@ --mathjax -C --bibliography $(BIB_SOURCE) --toc --metadata link-citations --metadata reference-section-title=Bibliography

clean : 
	- rm $(PDF_TARGET) $(HTML_TARGET)