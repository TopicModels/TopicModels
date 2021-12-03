PDF_TARGET = topicmodels.pdf
HTML_TARGET = index.html
TEXINFO_TARGET = $(TEXINFO_DIR)/index.html
TEX_SOURCE = topicmodels.tex
BIB_SOURCE = biblio.bib
FIG_SOURCE = $(wildcard fig/*)
TEXINFO_SOURCE = topicmodels.texi
TEXINFO_DIR = docs

.PHONY : all build pdf html clean texinfo

build : pdf html texinfo

all : clean build

pdf : $(PDF_TARGET)

html: $(HTML_TARGET)

$(PDF_TARGET) : $(TEX_SOURCE) $(BIB_SOURCE) $(FIG_SOURCE)
	tectonic $<

$(HTML_TARGET) : $(TEX_SOURCE) $(BIB_SOURCE) $(FIG_SOURCE)
	pandoc -s $< -o $@ --mathjax -C --bibliography $(BIB_SOURCE) --toc --metadata link-citations --metadata reference-section-title=Bibliography

texinfo: $(TEXINFO_TARGET)

$(TEXINFO_SOURCE): $(TEX_SOURCE) $(BIB_SOURCE) $(FIG_SOURCE)
	pandoc -s $< -o $@ -C --bibliography $(BIB_SOURCE) --metadata reference-section-title=Bibliography

$(TEXINFO_TARGET): $(TEXINFO_SOURCE)
	makeinfo --html --no-validate --force --set-customization-variable HTML_MATH=mathjax $< -o $(TEXINFO_DIR)

clean : 
	- rm $(PDF_TARGET) $(HTML_TARGET) $(TEXINFO_SOURCE) $(TEXINFO_DIR)/*