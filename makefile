all: build-book

imgs:
	@$(MAKE) -C bibook/msa/img 

build-book: imgs # select-conda-env
	jupyter-book build bibook/

#select-conda-env:
#	@if [ "$${CONDA_DEFAULT_ENV}" = "jb" ]; then \
#		conda activate jb; \
#	fi