---
name: mib-code-review
description: Review netdisco-mibs PRs for update process compliance, lost MIB/OID coverage, incompatible leaf types, and undocumented vendor fixes.
---

# MIB code review

Compare the PR against its merge base. Read the description, commit messages,
`AGENTS.md`, and affected vendors' `README` files. Apply import requirements only
to MIB changes.

## Update process

Check the applicable [Updating MIBs steps](https://github.com/netdisco/netdisco-mibs/wiki/Updating-MIBs)
against the diff and available evidence:

- Correct vendor directory: existing name or new vendor's enterprise identifier.
- `EXTRAS/scripts/prepmibs` preparation, flagged files resolved, dependencies and
  bundled RFCs handled separately; LF endings and valid, separate modules.
- Error-free `EXTRAS/scripts/testload <vendor>` for every imported vendor and
  `EXTRAS/scripts/genxlate`, using Net-SNMP 5.9+.
- Consistent `EXTRAS/reports/<vendor>` and `EXTRAS/reports/all` changes; update
  `EXTRAS/contrib/snmp.conf` for new vendors as needed.
- Agent-authored import commits summarize the essential steps from `AGENTS.md`.

Check command output: `testload` and `genxlate` can report errors yet exit zero.
Read actual LFS reports, not pointer hashes. Unchanged generated output needs no
commit; the separate OID-map/SQL workflow is not mandatory for each import.
Distinguish missing evidence from proven failure.

## Preserve coverage

Compare full affected modules and resolved numeric OIDs, accounting for renames,
moves, and module splits.

- Flag disappearing vendors, MIBs, subtrees, or leaves unless removal is explicitly
  scoped in the PR or linked request. Upstream omissions and deprecated status
  alone do not justify deletion. Still flag broken references after intended removals.
- Preserve local corrections and additions documented in vendor READMEs.
- Investigate report losses even without file deletions: missing imports, parser
  errors, and duplicate definitions can hide coverage.

## Preserve leaf types

Match leaves by full numeric OID, with module/symbol context, not merely a name
or final OID component. Flag reassigned OIDs and changed effective data types,
including changes inherited through textual conventions or imported types.
Equivalent type aliases are not type changes.

Flag incompatible enum meanings, units, ranges/sizes, indexes, or access;
distinguish compatible additions. Successful loading does not prove compatibility.

## Vendor notes

Require `<vendor>/README` updates for manual fixes, restored objects, deliberate
exclusions, or unusual preparation/dependency steps. Explain affected modules,
why the exception exists, and what future updates must preserve or repeat.
Ordinary imports need no README churn.

## Findings and validation

Give the file/line, module or OID, before/after behavior, and impact. Group subtree
losses; prioritize compatibility and loading failures. Report only supported,
PR-introduced issues and disclose unavailable checks or sources.

If reproducing validation, use a disposable container or microVM with a separate
checkout and isolated Git/SNMP configuration; scripts can rewrite files. Do not
alter the host, commit fixes, open PRs, or run release workflows during review.
