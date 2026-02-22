# GCSF Lean Phase A Plan

## Goal
- Build a Lean-typed skeleton for the core GCSF implication chain before deep analytic/arithmetic proofs.
- Keep all non-established ingredients explicit as assumptions.

## Scope (Phase A)
- Include core assumptions and theorem statements as Lean constants and structured hypotheses.
- Provide a compile-target theorem shell that matches the conditional main theorem path.
- Track TeX label to Lean declaration mapping.

## Out of Scope (Phase A)
- Full formal proofs of analytic trace-formula lemmas.
- Full arithmetic intersection and BSD factorization proofs.
- Any Mathlib-heavy number-theoretic construction.

## Milestones
1. Project scaffold: `lean-toolchain`, `lakefile.toml`, module tree.
2. Typed vocabulary layer: `/GCSF/Notation.lean`.
3. Assumption layer: `/GCSF/Assumptions.lean`.
4. Core theorem interface: `/GCSF/CoreDefinitions.lean`, `/GCSF/RegularChain.lean`, `/GCSF/SpectralChain.lean`, `/GCSF/EstablishedCaseChain.lean`, `/GCSF/AgreementChain.lean`, `/GCSF/GeometricChain.lean`, `/GCSF/MainChain.lean`, `/GCSF/KudlaChain.lean`, `/GCSF/LowRankChain.lean`, `/GCSF/FollowupChain.lean`.
5. Packaged orchestration interface: `PhaseAInput`/`PhaseBInput` and input-wrapper theorems in `/GCSF/MainChain.lean`.
6. Traceability: `/GCSF/LabelMap.lean`, `/docs/TEX_TO_LEAN_INVENTORY.md`, `/docs/AXIOM_REGISTRY.md`, `/docs/TEX_LABEL_AUDIT.md`.

## Verification Loop
1. Install Lean toolchain locally.
2. Run `lake build`.
3. Ensure `phaseA_main_theorem` typechecks.
4. When adding each new theorem, update inventory document and label map.

## Phase B Entry Criteria
- `phaseA_main_theorem` stays stable while replacing selected structured assumptions with actual proofs.
- `PhaseAInput` keeps explicit assumption-witness fields (`separation/well/isolating/exact-kernel/geometric/BSD`) plus `RegularChainInput` and uses theorem-backed defaults.
- Core assumptions/definitions (`WellDefinedA/Separation/Isolating/ExactKernel/Geometric/Kudla/BSD`) are modeled as `structure : Prop` and consumed via witness theorems.
- Global assumptions now theorem-backed:
  - `separation_assumption_theorem`
  - `isolating_test_exists_theorem`
  - `exact_kernel_near_center_theorem`
  - `geometric_realization_theorem`
  - `well_definedA_theorem`
  - `bsd_decomposition_theorem`
  - `general_kudla_identity_theorem`
- Regular core assumptions are now theorem-backed:
  - `diff_spectral_bridge_theorem`
  - `diff_spectral_bridge_from_separation`
  - `finite_regular_orbit_support_theorem`
  - `finite_regular_orbit_support_from_separation`
  - `analytic_regular_orbit_dependence_theorem`
  - `analytic_regular_orbit_dependence_from_separation`
  - `moment_vanishing_theorem`
  - `moment_vanishing_from_separation`
- Regular aggregation internals are now theorem-backed:
  - `index_vanishing_from_termwise_and_membership` (per-index witness with membership + scalar compatibility payload)
  - `termwise_to_indexed_vanishing` (index membership + index scalar compatibility witness)
  - `indexed_aggregation` (aggregated scalar compatibility + aggregated consistency witness)
  - `aggregate_scalar_from_witness`
  - `aggregate_to_orbitwise` (aggregated scalar/consistency를 orbitwise fields로 승격 + finite-support witness 소비)
  - `orbitwise_vanishing_from_termwise_and_separation`
- Spectral extraction internals are now theorem-backed (structured):
  - `local_isolation_data_from_exists`
  - `global_isolation_from_local`
  - `isolated_coefficient_from_global`
  - `kernel_adjustment_from_kernel_and_isolated`
  - `derivative_normalization_from_kernel_adjusted`
  - `central_derivative_package_from_normalization`
  - `exact_extraction_from_package`
- Agreement internals are now theorem-backed (structured):
  - `spectral_normalization_from_package`
  - `geometric_normalization_from_package`
  - `normalization_match_data`
  - `common_invariant_certificate_of_match`
  - `common_invariant_from_certificate`
  - `central_agreement_theorem`
- Final Phase-A theorem shells are now theorem-backed (structured):
  - `spec_geom_equality_theorem`
  - `phaseA_main_theorem`
- Follow-up interfaces are now theorem-backed (structured):
  - `central_parameterization_theorem`
  - `kill_other_pi_theorem`
  - `geometric_independence_theorem`
  - `independence_family_theorem`
  - `spectral_interpretation_theorem`
  - `selmer_rank_theorem`
  - `regulator_theorem`
  - `singular_as_height_cm_theorem`
- Additional structured interface upgrades:
  - regular-side wrappers: `TermwiseVanishingOnRegularOrbits`, `RegularOrbitIndexVanishes`,
    `RegularOrbitAggregateVanishes`, `OrbitwiseRegularVanishing`, `RegularOrbitVanishing`,
    `RegularTermsAnnihilated`
  - established-route wrappers: `EstablishedCaseInput`, `GeometricInterpretationEstablished`
  - agreement package wrappers: `SpectralCentralPackage`, `GeometricCentralPackage`
