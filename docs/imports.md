# Imports and reproducibility

The only direct external dependency is IAO release **2026-03-30**, including
its bundled supporting BFO/RO axioms. The source URL and SHA-256 are recorded in
`src/ontology/imports/iao.lock.json`. ROBOT is separately pinned in
`tools/robot.lock.json`. A changed download with the same URL fails checksum
verification instead of silently changing the build.

`make imports` uses ROBOT BOT extraction with the seeds in `iao_terms.txt`,
excludes individuals, and adds source attribution. Seeds include the annotation
properties needed to retain their original labels and definitions. The import
module has a VTDC-specific module IRI; original external entity IRIs and
annotations are retained. Its source ontology version is recorded in the module
header and lock. The extraction does not copy IAO's ontology-level creator or
title into VTDC metadata.

Commit the module, seed file, and lock. Normal builds resolve the module using
the XML catalog and merge the import closure into the distribution OWL file.
Users of that file therefore do not need live PURL resolution.

IAO's original ontology and its contributors are credited through retained term
annotations and the source link. See the upstream
[IAO repository](https://github.com/information-artifact-ontology/IAO) and its
[2026-03-30 release](https://github.com/information-artifact-ontology/IAO/releases/tag/v2026-03-30)
for the full source and licensing information. ROBOT is BSD-3-Clause licensed;
the downloaded tool is ignored by Git and is not a VTDC artifact.

Run `make test` to inspect both the strict VTDC report and the broader report.
The latter may retain inherited whitespace, missing-definition, or stylistic
findings. They are reported rather than silently rewritten in imported terms.
Any ERROR in the combined report fails validation. The complete merged ontology
also passes OWL 2 DL profile checking and HermiT reasoning.

No ICTV taxonomy release has been imported yet because the scaffold contains no
taxon-specific profiles. Before adding one, choose and pin its source release,
preserve ICTV IRIs, and record the report or proposal that supports each rule.
