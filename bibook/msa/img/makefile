# Define the source LaTeX file
BASENAME = phmm

# Automatically find extracted TikZ .tex files
TIKZ_FILES=$(wildcard $(BASENAME).tex)
# Define target PNG files based on the extracted TikZ .tex files
PNG_FILES=$(TIKZ_FILES:.tex=.png)

all: convert_png


# Rule to convert a TikZ .tex file into a PNG
convert_png:
	for file in $(BASENAME).tex; do \
		pdflatex "$$file"; \
		pdftoppm -png -r 300 "$${file%.tex}.pdf" > "$${file%.tex}.png"; \
	done

# Clean up auxiliary files
clean:
	rm -f $(BASENAME)*.aux
	rm -f $(BASENAME)*.log
	rm -f $(BASENAME)*.pdf
	rm -f $(PNG_FILES)

.PHONY: all clean
