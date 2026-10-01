# Modeling decisions

The [shared ViralTaxonomy conversation](https://chatgpt.com/share/6abea53f-c988-83ea-a0da-e7af2d6e5ce7)
supplied the architecture. VTDC keeps criterion meaning separate from taxonomic
scope, instance records, and procedural execution. This is a scaffold of that
architecture, not a completed classification engine.

```text
IAO:0000030 information content entity
└── VTDC:0000001 taxonomic demarcation information entity
    ├── VTDC:0000002 viral taxon demarcation criterion
    │   ├── VTDC:0000003 sequence-based demarcation criterion
    │   │   ├── VTDC:0000004 sequence identity demarcation criterion
    │   │   │   ├── VTDC:0000005 nucleotide sequence identity demarcation criterion
    │   │   │   └── VTDC:0000006 amino acid sequence identity demarcation criterion
    │   │   ├── VTDC:0000007 evolutionary distance demarcation criterion
    │   │   ├── VTDC:0000008 gene content demarcation criterion
    │   │   └── VTDC:0000009 phylogenetic placement demarcation criterion
    │   ├── VTDC:0000010 genome organization demarcation criterion
    │   ├── VTDC:0000011 virion morphology demarcation criterion
    │   ├── VTDC:0000012 host range demarcation criterion
    │   ├── VTDC:0000013 antigenic demarcation criterion
    │   ├── VTDC:0000014 ecological demarcation criterion
    │   └── VTDC:0000015 biological property demarcation criterion
    ├── VTDC:0000016 composite demarcation rule
    │   ├── VTDC:0000019 conjunctive demarcation rule
    │   └── VTDC:0000020 disjunctive demarcation rule
    ├── VTDC:0000017 taxon demarcation profile
    └── VTDC:0000018 taxonomic classification assessment
```

Criteria, rules, and profiles additionally subclass IAO:0000033, directive
information entity. An assessment is a record of an evaluation result, not the
evaluation process itself. It therefore stays under information content entity.
The broad root is deliberately not a directive, so assessments are not forced
to be instructions.

Classes of criteria classify **criterion specifications** as information
entities. They do not classify viruses or measurements. Later instance records
will instantiate the appropriate criterion type; no redundant parallel class
hierarchy for "criterion specifications" is needed.

The initial asserted hierarchy is intentionally conservative. Host-range,
antigenic, ecological, and other criteria may overlap; no disjointness or
exhaustive partition is asserted. Conjunctive and disjunctive rules have textual
definitions, but no numeric computation or closed-world decision semantics is
encoded in their OWL axioms.

## Next modeling layers

| Layer | Planned representation |
| --- | --- |
| Taxa and ranks | Reuse original ICTV ontology identifiers; extract only required taxa after choosing a release |
| Criterion specifications | Versioned individuals typed with VTDC criterion classes |
| Taxon profiles | Individuals of VTDC:0000017 with taxonomic scope, target rank, release, components, and provenance |
| Methods and measurements | Reuse suitable IAO/OBI/STATO/SO/UO/ECO concepts after term review |
| Assessment records | Individuals of VTDC:0000018 linked to the evaluated profile and supporting evidence |
| Execution | A separately versioned DSL plus structural validation; actual sequence comparison runs outside OWL |

Do not make family-specific subclasses of general sequence-identity criteria.
Share a specification across profiles only when its complete semantics match:
method and version, comparison region, metric, comparator, threshold, units,
reference set, and aggregation policy.

Before minting relations such as "applies to taxon", "has criterion component",
or "evaluated against", review RO and IAO for suitable existing relations and
decide whether the target is an instance or a class. An OWL object-property link
to an ICTV class IRI introduces class/individual punning; it does not by itself
express a restriction on members of that class. Choose that representation
explicitly when introducing the knowledge base.

For composite rules, preserve AND/OR, required versus supporting evidence,
expert judgment, exceptions, and the distinction between existing-taxon
membership and evidence for proposing a new taxon. Missing data must not be
silently treated as a negative result. No fake taxa, reference sequences, or
example numerical cutoffs are included in this scaffold.
