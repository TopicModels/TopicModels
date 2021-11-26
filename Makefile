PDF_TARGET = topicmodels.pdf
HTML_TARGET = index.html
TEX_SOURCE = topicmodels.tex
BIB_SOURCE = biblio.bib
FIG_SOURCE = $(wildcard fig/*)

.PHONY : all pdf html clean

all : pdf html

pdf : $(PDF_TARGET)

html: $(HTML_TARGET)

$(PDF_TARGET) : $(TEX_SOURCE) $(BIB_SOURCE) $(FIG_SOURCE)
	tectonic $<

$(HTML_TARGET) : $(TEX_SOURCE) $(BIB_SOURCE) $(FIG_SOURCE)
	pandoc -s $< -o $@ --mathjax -C --bibliography $(BIB_SOURCE) --metadata link-citations

clean : 
	- rm $(PDF_TARGET) $(HTML_TARGET)