SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.DEFAULT_GOAL := all

ROBOT := ./tools/robot
EDIT := src/ontology/vtdc-edit.owl
IMPORT := src/ontology/imports/iao_import.owl
CATALOG := src/ontology/catalog-v001.xml
QUERIES := $(sort $(wildcard src/sparql/*-violation.rq))
PRODUCTS := vtdc.owl vtdc.obo vtdc.json

.PHONY: all setup build test imports clean release help
all: test build
setup:
	$(ROBOT) --version

build: $(PRODUCTS)

build/vtdc-merged.owl: $(EDIT) $(IMPORT) $(CATALOG) Makefile tools/robot.lock.json
	mkdir -p build
	$(ROBOT) merge --input $(EDIT) --catalog $(CATALOG) --collapse-import-closure true --output $@

build/vtdc-reasoned.owl: build/vtdc-merged.owl
	$(ROBOT) reason --input $< --reasoner HermiT --equivalent-classes-allowed none --exclude-tautologies all --output $@

vtdc.owl: build/vtdc-reasoned.owl
	$(ROBOT) annotate --input $< --ontology-iri https://purl.obolibrary.org/obo/vtdc.owl --version-iri https://purl.obolibrary.org/obo/vtdc/dev/vtdc.owl --annotation owl:versionInfo "development snapshot" --output $@

vtdc.obo: vtdc.owl
	$(ROBOT) convert --input $< --format obo --check true --output $@

vtdc.json: vtdc.owl
	$(ROBOT) convert --input $< --format json --output $@

test: build/vtdc-reasoned.owl
	mkdir -p build/reports
	$(ROBOT) validate-profile --input build/vtdc-merged.owl --profile DL --output build/reports/owl2-dl.txt
	$(ROBOT) report --input build/vtdc-reasoned.owl --base-iri http://purl.obolibrary.org/obo/VTDC_ --fail-on WARN --output build/reports/vtdc-report.tsv
	$(ROBOT) verify --input build/vtdc-reasoned.owl --queries $(QUERIES) --output-dir build/reports
	$(ROBOT) report --input build/vtdc-reasoned.owl --fail-on ERROR --output build/reports/import-inclusive-report.tsv

# Import refresh is explicit: normal builds use the checked-in local module.
imports:
	python3 tools/fetch.py src/ontology/imports/iao.lock.json build/upstream/iao.owl
	$(ROBOT) extract --input build/upstream/iao.owl --method BOT --term-file src/ontology/imports/iao_terms.txt --individuals exclude --annotate-with-source true annotate --ontology-iri https://purl.obolibrary.org/obo/vtdc/imports/iao_import.owl --version-iri https://purl.obolibrary.org/obo/vtdc/imports/2026-03-30/iao_import.owl --annotation rdfs:comment "ROBOT BOT module extracted from IAO 2026-03-30; retain original term IRIs and attribution." --link-annotation http://purl.org/dc/terms/source http://purl.obolibrary.org/obo/iao/2026-03-30/iao.owl --output $(IMPORT)

# Stages local artifacts only. Does not tag, commit, upload, or publish.
release:
	python3 tools/check-release-date.py "$(RELEASE_DATE)"
	$(MAKE) test
	mkdir -p releases/$(RELEASE_DATE)
	$(ROBOT) annotate --input build/vtdc-reasoned.owl --ontology-iri https://purl.obolibrary.org/obo/vtdc.owl --version-iri https://purl.obolibrary.org/obo/vtdc/releases/$(RELEASE_DATE)/vtdc.owl --annotation owl:versionInfo "$(RELEASE_DATE)" --output releases/$(RELEASE_DATE)/vtdc.owl
	$(ROBOT) convert --input releases/$(RELEASE_DATE)/vtdc.owl --format obo --check true --output releases/$(RELEASE_DATE)/vtdc.obo
	$(ROBOT) convert --input releases/$(RELEASE_DATE)/vtdc.owl --format json --output releases/$(RELEASE_DATE)/vtdc.json
	cd releases/$(RELEASE_DATE) && sha256sum vtdc.owl vtdc.obo vtdc.json > SHA256SUMS

clean:
	rm -rf build
	rm -f $(PRODUCTS)

help:
	@echo 'make all | test | build | imports | clean | release RELEASE_DATE=YYYY-MM-DD'
