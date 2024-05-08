.ONESHELL:
SHELL = /bin/bash

CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate

all: build-book

imgs:
	@$(MAKE) -C bibook/msa/img 

build-book: imgs select-conda-env
	$(CONDA_ACTIVATE) jb; jupyter-book build bibook/

