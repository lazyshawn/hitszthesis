#!/bin/bash

echo -n "========== Xelatex No.1 =========="
xelatex main.tex
echo -n "========== Compile references =========="
bibtex main
echo -n "========== Xelatex No.2 =========="
xelatex main.tex
echo -n "========== Xelatex No.3 =========="
xelatex main.tex


