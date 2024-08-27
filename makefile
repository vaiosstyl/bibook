.ONESHELL:
SHELL = /bin/bash

CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate
# Variables
BOOK_DIR=bibook
BUILD_DIR=$(BOOK_DIR)/_build/latex
TEX_FILE=$(BUILD_DIR)/bibook.tex
PDF_FILE=$(BUILD_DIR)/bibook.pdf


all: build-book $(PDF_FILE)

imgs:
	@$(MAKE) -C bibook/msa/img 

build-book: imgs
	$(CONDA_ACTIVATE) jb; jupyter-book build bibook/

# Step 1: Build the book with Jupyter Book using the LaTeX builder
$(BUILD_DIR):
	jupyter-book build --builder latex $(BOOK_DIR)

# Step 2: Replace all occurrences of "align*" with "aligned" in bibook.tex
$(TEX_FILE): $(BUILD_DIR)
	sed -i 's/align\*/aligned/g' $(TEX_FILE)

# Step 3: Compile the LaTeX file to PDF using latexmk
$(PDF_FILE): $(TEX_FILE)
	cd $(BUILD_DIR) && latexmk -f -pdf -dvi- bibook.tex

# Clean up build files
clean:
	cd $(BUILD_DIR) && latexmk -c

# Clean up everything including the PDF
clean-all:
	cd $(BUILD_DIR) && latexmk -C && rm -f $(PDF_FILE)

.PHONY: all clean clean-all


