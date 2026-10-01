# Contributing to VTDC

Discuss scope and modeling with John D. Osborne until a public issue tracker
is established. Once GitHub exists, use the term-request and PR templates.

1. Search VTDC and relevant existing ontologies before minting a term. Reuse
   IAO/BFO/RO, and later ICTV, OBI, STATO, SO, UO, or ECO as appropriate.
2. Allocate a never-used identifier from [your range](docs/identifiers.md).
3. Edit `src/ontology/vtdc-edit.owl`, not the generated root products or imports.
   Use a concise singular lower-case label and a genus-and-differentia definition.
4. Add an asserted superclass, `dcterms:creator`, `IAO:0000117` (term editor),
   and an `IAO:0000119` definition-source annotation **on the definition axiom**.
   Include a durable report/proposal identifier and section for curated content.
5. Use exact, broad, narrow, and related synonyms accurately; a synonym is not
   evidence of equivalence. Add existing synonym properties through imports.
6. Run `make all`. Inspect both the VTDC and import-inclusive quality reports.
   Review the OWL/OBO/JSON products before including them in a release.

No published ID may be reused, even if its term is removed from active use.
Deprecate obsolete terms with `owl:deprecated true`, an obsoletion explanation,
and an appropriate replacement/consider annotation. Retain historical meaning;
use a new ID for a substantive change of meaning. Extend QC deliberately to
support deprecated terms when the first obsoletion is introduced.

Definitions in the initial scaffold are provisional. Do not treat shared-chat
provenance as authoritative support for a taxon-specific scientific rule. Such
rules require the relevant versioned ICTV report or proposal and expert review.

For an import update, change its source URL, version, and SHA-256 together,
review seed terms and the Makefile's version annotation, run `make imports`,
then review the diff and run `make all`. Never hand-edit imported definitions.
