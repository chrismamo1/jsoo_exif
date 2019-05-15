################################################################################
MLI_FILE		= jsoo_exif.mli

## Name which will be used in -package with ocamlfind
LIB_NAME		= jsoo_exif
################################################################################

################################################################################
CC				= ocamlc
PACKAGES		= -package js_of_ocaml -package lwt

ML_FILE			= $(patsubst %.mli, %.ml, $(MLI_FILE))
CMI_FILE		= $(patsubst %.mli, %.cmi, $(MLI_FILE))
CMO_FILE		= $(patsubst %.mli, %.cmo, $(MLI_FILE))
CMA_FILE		= $(LIB_NAME).cma
################################################################################

################################################################################
all: build

#%.ml: %.mli
#	ocamlfind gen_js_api/gen_js_api $<
#	ocamlfind $(CC) -c $(PACKAGES) $<
#	ocamlfind $(CC) -c $(PACKAGES) $@

%.cmi: %.mli
	ocamlfind $(CC) -c $(PACKAGES) $<

%.cmo: %.ml | %.cmi
	ocamlfind $(CC) -c $(PACKAGES) $<

build: $(CMO_FILE) $(CMI_FILE)
	ocamlfind $(CC) -no-check-prims -a -o $(CMA_FILE) $(CMO_FILE) -linkall

install: build
	ocamlfind install $(LIB_NAME) META $(CMA_FILE) $(CMI_FILE)
	cp jsoo_exif.js `ocamlfind query $(LIB_NAME)`

remove uninstall:
	ocamlfind remove $(LIB_NAME)

clean:
	$(RM) $(CMI_FILE) $(CMO_FILE) $(CMA_FILE)

re: clean all
################################################################################