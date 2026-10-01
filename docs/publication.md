# Local releases and future publication

Root products are explicitly marked as **development snapshots**, not published
releases. Ordinary builds do not insert the current date or change version IRIs.
All external imports are merged into the main OWL distribution.

To stage a dated release locally:

```bash
make release RELEASE_DATE=YYYY-MM-DD
```

Replace `YYYY-MM-DD` with a real calendar date. This runs QC, creates OWL,
OBO, OBO Graphs JSON, and SHA-256 checksums under `releases/<date>/`, and sets a
dated version IRI and `owl:versionInfo`. The command refuses to replace an
existing staged release. It does not commit, tag, upload, or publish anything.

Review the staged artifacts, update `CHANGELOG.md` and citation metadata, and
record the exact source commit before publishing. Never replace a published
dated release. OBO and OBO Graphs are convenience exports; OWL is authoritative
for complete logical axioms and annotations.

## When the GitHub repository exists

1. Add the actual repository URL and public contact information to README,
   `CITATION.cff`, and ontology metadata (for example, `rdfs:seeAlso`). Add an
   ORCID for John D. Osborne only after it is supplied or confirmed.
2. Add the Git remote and push this project. CI will run `make all` and retain
   reports and development products. Configure required checks for contributions.
3. Review the initial concepts and definitions with domain experts, especially
   their provenance and relation to the original ViralTaxonomy framework.
4. Complete namespace collision checks and apply to the OBO Foundry for VTDC.
   Configure ontology, release, import, and term PURL redirects after approval.
5. Prepare the official OBO registry metadata using the real homepage, tracker,
   maintainer email, license, and product URLs. None are fabricated here.
6. Publish a reviewed release with an immutable tag, artifacts, and citation
   version. Decide how term pages will resolve (for example, an ontology browser).

Passing local QC is not OBO Foundry membership. Community review, namespace
registration, public availability, documented use, and continuing maintenance
remain separate requirements.
