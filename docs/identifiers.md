# Identifier policy

- Proposed prefix: `VTDC` (not yet registered with OBO).
- Term CURIE: `VTDC:0000001`.
- Term IRI: `http://purl.obolibrary.org/obo/VTDC_0000001`.
- Prospective ontology IRI: `https://purl.obolibrary.org/obo/vtdc.owl`.
- Editable ontology IRI: `https://purl.obolibrary.org/obo/vtdc/vtdc-edit.owl`.
- Development version IRI: `https://purl.obolibrary.org/obo/vtdc/dev/vtdc.owl`.
- Release version IRI: `https://purl.obolibrary.org/obo/vtdc/releases/YYYY-MM-DD/vtdc.owl`.

Term IDs have seven digits with no encoded biological meaning. The HTTP term
base follows the OBO ID policy; the HTTPS ontology IRI follows the current
Principle 3 recommendation. These are distinct RDF IRIs: do not mechanically
rewrite one scheme into the other. Confirm the prospective PURL routes during
registration before public release.

| Inclusive range | Allocation |
| --- | --- |
| 0000001–0000999 | Initial scaffold; 0000001–0000020 currently assigned |
| 0001000–0099999 | John D. Osborne |
| 0100000–9999999 | Unallocated; allocate separate ranges to future editors |

Configure Protégé's new-entity IRI settings to use the term base and your
allocated range before creating terms. Track new allocations in this document.
Never recycle an assigned identifier. Class labels can improve without changing
the ID when the intended meaning is preserved.

The OBO registry was checked for VTDC during scaffolding, with no matching entry
found. This does not reserve the namespace: complete OBO, Bioregistry, and
BioPortal collision checks and namespace registration before publication.
