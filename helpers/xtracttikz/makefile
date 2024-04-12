# Define the source LaTeX file
BASENAME = alignments

# Automatically find extracted TikZ .tex files
TIKZ_FILES=$(wildcard $(BASENAME)_tikz_*.tex)
# Define target PNG files based on the extracted TikZ .tex files
PNG_FILES=$(TIKZ_FILES:.tex=.png)

all: extract convert_png


# Extract TikZ figures from the source .tex file
extract:
	bash extract_tikz.sh $(BASENAME).tex

# Rule to convert a TikZ .tex file into a PNG
convert_png:
	for file in $(BASENAME)_tikz_*.tex; do \
		pdflatex "$$file"; \
		pdftoppm -png -r 300 "$${file%.tex}.pdf" > "$${file%.tex}.png"; \
	done

# Clean up auxiliary files
clean:
	rm -f $(BASENAME)_tikz_*.tex
	rm -f $(BASENAME)_tikz_*.aux
	rm -f $(BASENAME)_tikz_*.log
	rm -f $(BASENAME)_tikz_*.pdf
	rm -f $(PNG_FILES)

.PHONY: all extract clean
