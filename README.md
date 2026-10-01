# Viral Taxon Demarcation Criteria Ontology (VTDC)

VTDC describes reusable criteria for distinguishing viral taxa, composite
demarcation rules, taxon demarcation profiles, and classification assessments.

This is a development scaffold, with 20 provisional VTDC classes and a pinned
Information Artifact Ontology (IAO) import containing the required BFO and RO
support. The initial architecture follows the
[ViralTaxonomy framework](https://chatgpt.com/share/6abea53f-c988-83ea-a0da-e7af2d6e5ce7).
Definitions are original draft formulations for domain review, not quotations
or assertions of ICTV approval.VTDC is a **proposed, unregistered namespace**. It
has not yet been submitted for OBO Foundry acceptance.

## Get started
Requires Java 21, Python 3.11 or later, GNU Make, and internet access for the
first ROBOT download. No Python packages or Docker image are required.

```bash
make setup     # installs/verifies checksum-pinned ROBOT 1.9.10 locally
make all       # reason, validate, run QC, and build all three products
```

Open [`src/ontology/vtdc-edit.owl`](src/ontology/vtdc-edit.owl) in Protégé to
edit the ontology. Keep its sibling `catalog-v001.xml` and `imports/` directory
together; they resolve the import locally. The editable file uses OWL Functional
Syntax. The generated root `vtdc.owl` uses RDF/XML.

After setup, ordinary builds use the checked-in import module and can run
offline. ROBOT and upstream IAO are downloaded only from checksum-locked URLs;
`make imports` explicitly regenerates the module.

## Layout and products

| Path | Purpose |
| --- | --- |
| `src/ontology/vtdc-edit.owl` | Authoritative editable ontology |
| `src/ontology/imports/` | Checked-in IAO module, seeds, and source lock |
| `src/sparql/` | Project-specific quality checks |
| `vtdc.owl` | Merged, reasoned development snapshot; authoritative distribution format |
| `vtdc.obo` | OBO-format export; consumers should use OWL for full semantics |
| `vtdc.json` | OBO Graphs JSON export, not JSON-LD |
| `build/reports/` | ROBOT reports and SPARQL check results |
| `data/` | Reserved for versioned criterion specifications and profile instances |
| `rules/` | Reserved for a future executable rule language and validation shapes |
| `.github/` | CI and contribution templates ready for a future GitHub repository |

The layout follows common OBO development conventions. This is a small,
hand-maintained ROBOT/Make project, **not an ODK-generated repository**; there
is no fictitious ODK configuration or dependency on its large container image.

## Modeling and quality

Criterion types form a reusable hierarchy. A taxon-specific profile will be an
instance linked to external ICTV identifiers, a taxonomy release, and its source
documents. A numeric threshold alone does not identify a criterion: the method,
region, unit, comparator, and reference set matter too.

`make all` checks OWL 2 DL compliance, consistency and satisfiability with
HermiT, unintended named-class equivalence, ROBOT reports, local identifier
format, required ontology metadata, definition provenance, and ancestry under
IAO information content entity. VTDC errors and warnings fail CI. Errors
anywhere in the merged ontology also fail CI; inherited external warnings and
informational findings remain visible in the import-inclusive report.

See [modeling](docs/modeling.md), [contributing](CONTRIBUTING.md),
[identifiers](docs/identifiers.md), [imports](docs/imports.md), and
[release instructions](docs/publication.md).

## Attribution and license

Original VTDC content is licensed under
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
Credit John D. Osborne and VTDC; cite the release version and original term
identifiers. External terms retain their original IRIs and provenance. See
[`LICENSE`](LICENSE), [`AUTHORS.md`](AUTHORS.md), and [`CITATION.cff`](CITATION.cff).

## Guidance used

- [OBO Foundry principles](https://obofoundry.org/principles/fp-000-summary.html)
- [OBO identifiers](https://obofoundry.org/id-policy.html) and
  [URI/identifier-space requirements](https://obofoundry.org/principles/fp-003-uris.html)
- [ROBOT](https://robot.obolibrary.org/), including
  [extraction](https://robot.obolibrary.org/extract.html),
  [reasoning](https://robot.obolibrary.org/reason.html), and
  [quality reports](https://robot.obolibrary.org/report.html)
- [ICTV taxonomy explanation](https://ictv.global/about/taxonomy)
- [IAO](https://github.com/information-artifact-ontology/IAO)
- [ICTV ontology](https://github.com/EVORA-project/ictv-ontology), for future taxon reuse
