#!/bin/bash
# This is needed by the main.yml above

DOCS="main"
DEST="pdfs"

[[ -d $DEST ]] || mkdir $DEST

# xelatex does not work
for arg in $DOCS
do
    [[ -f ${arg}.aux ]] && rm ${arg}.aux
    pdflatex $arg 
    biber $arg
    pdflatex $arg
    pdflatex $arg
    [[ -f ${arg}.pdf ]] && mv ${arg}.pdf $DEST
done
