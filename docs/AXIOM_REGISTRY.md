# Axiom Registry (Phase A)

This file tracks all remaining `axiom` declarations after the current decomposition pass.

## Count
- Total remaining axioms: `0`

## By Module

### `/GCSF/RegularChain.lean`
- (none; replaced by theorem-backed regular bridge declarations)

### `/GCSF/SpectralChain.lean`
- (none)

### `/GCSF/EstablishedCaseChain.lean`
- (none)

### `/GCSF/AgreementChain.lean`
- (none)

### `/GCSF/GeometricChain.lean`
- (none)

### `/GCSF/MainChain.lean`
- (none)

## Next Reduction Surface (Post-axiom)
- `axiom`은 0개이며, 핵심 가정/정의 7개는 `structure ... : Prop`로 승격되었다.
- 다음 단계는 현재 교차 등식(`A`/`LambdaDeriv`) + 전칭 명제 기반 scaffold 필드를 내용 있는 수학 명제로 대체하는 것이다.
- 주요 대상:
  - `WellDefinedA`
  - `SeparationAssumption`
  - `IsolatingTestExists`
  - `ExactKernelNearCenter`
  - `GeometricRealization`
  - `GeneralKudlaIdentity`
  - `BSDDecomposition`

## Theorem-backed Assumption Witnesses
- `separation_assumption_theorem`
- `isolating_test_exists_theorem`
- `exact_kernel_near_center_theorem`
- `geometric_realization_theorem`
- `general_kudla_identity_theorem`
- `bsd_decomposition_theorem`

## Recent Proof Replacements (Regular Aggregation Internals)
- `index_vanishing_from_termwise_and_membership` (theorem-backed; per-index witness with membership + scalar compatibility payload)
- `termwise_to_indexed_vanishing` (theorem-backed; index membership + index scalar compatibility witness)
- `indexed_aggregation` (theorem-backed; aggregated scalar compatibility + aggregated consistency witness)
- `aggregate_scalar_from_witness` (theorem-backed; reads aggregated scalar identity from indexed witnesses)
- `aggregate_to_orbitwise` (theorem-backed; lifts aggregated scalar/consistency fields to orbitwise fields while consuming finite-support witnesses)
- `orbitwise_vanishing_from_termwise_and_separation` (theorem-backed; keeps separation dependency through aggregation stage)

## Recent Proof Replacements (Regular/Established Interface Structures)
- `termwise_vanishing_from_inputs` (theorem-backed; structured termwise witness)
- `regular_chain_input_from_separation` / `regular_chain_input_theorem` / `regular_orbit_vanishing_from_chain_input` / `regular_annihilation_from_chain_input` (theorem-backed; 7-field regular input package + downstream annihilation bridge)
- `regular_annihilation_from_orbitwise` (theorem-backed; structured annihilation witness)
- `established_case_interpretation_from_input` (theorem-backed; structured established-interpretation witness)
- `established_to_general_realization_from_interpretation` (theorem-backed; structured conversion to geometric realization)

## Recent Proof Replacements (Spectral Extraction Internals)
- `local_isolation_data_from_exists` (theorem-backed; structured local isolation witness)
- `global_isolation_from_local` (theorem-backed; structured globalization witness)
- `isolated_coefficient_from_global` (theorem-backed; structured isolated-coefficient witness)
- `kernel_adjustment_from_kernel_and_isolated` (theorem-backed; structured kernel-adjusted witness)
- `derivative_normalization_from_kernel_adjusted` (theorem-backed; structured derivative-normalization witness)
- `central_derivative_package_from_normalization` (theorem-backed; structured central-package witness)
- `exact_extraction_from_package` (theorem-backed; structured exact-extraction witness)

## Recent Proof Replacements (Agreement Internals)
- `spectral_normalization_from_package` (theorem-backed; structured spectral-normalization witness)
- `geometric_normalization_from_package` (theorem-backed; structured geometric-normalization witness)
- `normalization_match_data` (theorem-backed; structured normalization-match witness)
- `common_invariant_certificate_of_match` (theorem-backed; structured certificate witness)
- `common_invariant_from_certificate` (theorem-backed; structured common-invariant witness)
- `central_agreement_theorem` (theorem-backed; structured agreement witness)

## Recent Proof Replacements (Phase A Final Shells)
- `spec_geom_equality_theorem` (theorem-backed; structured spectral-geometric witness)
- `phaseA_main_theorem` (theorem-backed; structured conditional witness)

## Recent Proof Replacements (Follow-up Structured Interfaces)
- `central_parameterization_theorem` (theorem-backed; structured follow-up witness)
- `kill_other_pi_theorem` (theorem-backed; structured follow-up witness)
- `geometric_independence_theorem` (theorem-backed; structured follow-up witness)
- `independence_family_theorem` (theorem-backed; structured follow-up witness)
- `spectral_interpretation_theorem` (theorem-backed; structured follow-up witness)
- `selmer_rank_theorem` (theorem-backed; structured follow-up witness)
- `regulator_theorem` (theorem-backed; structured follow-up witness)
- `singular_as_height_cm_theorem` (theorem-backed; structured follow-up witness)

## Recent Proof Replacements (Phase B Kudla Bridges)
- `phaseA_input` / `phaseA_input_default` / `phaseA_input_reduced` (definition-backed; explicit/default/reduced Phase A input constructor 계층)
- `phaseA_regular_chain_consistency` / `phaseA_regular_from_input` (theorem-backed; Phase A packaged regular-bridge consistency + direct regular extraction)
- `phaseA_assumption_snapshot_from_input` / `phaseA_assumption_snapshot_reduced` (theorem-backed; packaged/reduced Phase A top-level assumption snapshot)
- `phaseA_regular_then_main_reduced` / `phaseA_dependency_snapshot_reduced` / `phaseA_expanded_snapshot_reduced` (theorem-backed; reduced Phase A wrapper 계층)
- `phaseB_input` / `phaseB_input_from_phaseA` / `phaseB_input_from_phaseA_default` / `phaseB_input_reduced` (definition-backed; explicit Kudla constructor path + theorem-backed default path 분리)
- `PhaseBAssumptionSnapshot` / `phaseB_assumption_snapshot_from_input` / `phaseB_assumption_snapshot_reduced` (structure/definition-backed; packaged/reduced Phase B assumption snapshot payload)
- `phaseB_regular_from_input` / `phaseB_result_snapshot_from_input` / `phaseB_result_snapshot_reduced` (theorem-backed; packaged/reduced Phase B regular+conditional extraction snapshot)
- `phaseB_kudla_intermediate` (theorem-backed; `GeneralKudlaIdentity`의 coeff/deriv/consistency payload를 Phase B 중간 보조정리로 분리)
- `kudla_arithmetic_identity` / `kudla_derivative_identity` / `kudla_consistency_identity` (theorem-backed; reusable `GeneralKudlaIdentity` field accessors, including consistency field)
- `kudla_assumption_from_input` / `kudla_assumption_from_phaseA` / `kudla_assumption_from_phaseA_default` (theorem-backed; input/explicit/default Kudla witness projections)
- `kudla_regular_from_input` / `kudla_regular_from_phaseA` / `kudla_regular_from_phaseA_default` / `phaseB_conditional_from_input` / `kudla_conditional_from_phaseA` / `kudla_conditional_from_phaseA_default` (theorem-backed; packaged/explicit/default regular+conditional projections)
- `phaseB_main_with_kudla_from_phaseA` / `phaseB_main_with_kudla_from_phaseA_default` / `phaseB_main_with_kudla_reduced` (theorem-backed; explicit/default/reduced wrapper 계층)
- `phaseB_regular_then_main_from_phaseA` / `phaseB_regular_then_main_from_phaseA_default` / `phaseB_regular_then_main_reduced` (theorem-backed; explicit/default/reduced wrapper 계층)
- `isolating_test_from_conditional` / `exact_kernel_from_conditional` / `geometric_realization_from_conditional` / `central_derivative_from_conditional` (theorem-backed; extracts follow-up input witnesses from `GCSFConditional`)
- `kudla_isolating_kernel_data` / `kudla_geometric_data` / `kudla_exact_spectral_data` (theorem-backed; intermediate data lemmas now reusing conditional-extraction path)
- `kudla_isolating_kernel_data_from_conditional` / `kudla_geometric_data_from_conditional` / `kudla_exact_spectral_data_from_conditional` (theorem-backed; combines conditional-extracted witnesses with Kudla identities)
- `kudla_phaseB_snapshot_from_phaseA` / `kudla_phaseB_snapshot_from_phaseA_default` / `kudla_phaseB_snapshot_reduced` (theorem-backed; explicit/default/reduced Kudla snapshot 계층)
- `phaseB_followup_snapshot_from_kudla_and_conditional` / `phaseB_followup_snapshot_from_phaseA` / `phaseB_followup_snapshot_from_phaseA_default` / `phaseB_followup_snapshot_reduced` (theorem-backed; core combiner + explicit/default/reduced follow-up snapshot 계층)
- `low_rank_prop_r0_from_phaseA` / `low_rank_prop_r0_from_phaseA_default` / `low_rank_prop_r0_reduced` / `low_rank_prop_r1_chain_from_phaseA` / `low_rank_prop_r1_chain_from_phaseA_default` / `low_rank_prop_r1_chain_reduced` / `low_rank_snapshot_from_phaseA` / `low_rank_snapshot_from_phaseA_default` / `low_rank_snapshot_reduced` (theorem-backed; explicit/default/reduced low-rank wrapper 계층)
- `central_parameterization_of_kudla` / `kill_other_pi_of_kudla` / `geometric_independence_of_kudla` / `exact_spectral_extraction_of_kudla` / `singular_as_height_cm_of_kudla` (theorem-backed; rebuilt to consume Kudla-derived intermediate data directly)

## Recent Proof Replacements (Regular Core Assumptions)
- `diff_spectral_bridge_theorem` (theorem-backed; structured bridge witness)
- `diff_spectral_bridge_from_separation` (theorem-backed; consumes `SeparationAssumption` directly)
- `finite_regular_orbit_support_theorem` (theorem-backed; structured support witness)
- `finite_regular_orbit_support_from_separation` (theorem-backed; consumes `SeparationAssumption` directly)
- `analytic_regular_orbit_dependence_theorem` (theorem-backed; structured analytic witness)
- `analytic_regular_orbit_dependence_from_separation` (theorem-backed; consumes `SeparationAssumption` directly)
- `moment_vanishing_theorem` (theorem-backed; structured moment witness)
- `moment_vanishing_from_separation` (theorem-backed; consumes `SeparationAssumption` directly)

## Recent Proof Replacements (Global Assumptions)
- `well_definedA_theorem` (theorem-backed; coeff/deriv + consistency field)
- `bsd_decomposition_theorem` (theorem-backed; coeff/deriv + consistency field)
- `general_kudla_identity_theorem` (theorem-backed)
- `separation_assumption_theorem` (theorem-backed; finite/test-family + consistency field)
- `isolating_test_exists_theorem` (theorem-backed; rankwise/center + center consistency field)
- `exact_kernel_near_center_theorem` (theorem-backed; center/all-rank + consistency field)
- `geometric_realization_theorem` (theorem-backed; coeff/deriv + consistency field)
