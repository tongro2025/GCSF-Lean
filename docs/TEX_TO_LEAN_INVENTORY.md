# TeX to Lean Inventory (Snapshot)

## Core Phase A Chain

| TeX label | TeX location intent | Lean declaration |
|---|---|---|
| `ass:separation` | separating test functions on finite regular set | `SeparationAssumption` |
| `lem:diff-spectral` | differentiability bridge for spectral expansion | `diff_spectral_bridge_theorem` / `DiffSpectralBridge` |
| `lem:finite-orbits` | finiteness of regular-orbit support | `finite_regular_orbit_support_theorem` / `FiniteRegularOrbitSupport` |
| `lem:analytic-oi` | analytic dependence of regular orbital integrals | `analytic_regular_orbit_dependence_theorem` / `AnalyticRegularOrbitDependence` |
| `prop:moment-vanishing` | admissible-family moment vanishing | `moment_vanishing_theorem` / `MomentVanishing` |
| `prop:termwise-vanish` | termwise vanishing propagation | `termwise_vanishing_from_inputs` / `TermwiseVanishingOnRegularOrbits` (`structure`) |
| `prop:regular-vanishing` | geometric regular-orbit vanishing | `orbitwise_vanishing_theorem` + `RegularOrbitVanishing` (`structure`) |
| `thm:Dr-kills-regular` | regular geometric contribution annihilation | `regular_annihilation_theorem` |
| `thm:GCSF-well-defined` | well-defined normalized invariant `A_r(E)` | `well_definedA_theorem` / `WellDefinedA` |
| `ass:isolating-test` | existence of isolating test function | `IsolatingTestExists` |
| `ass:exact-kernel` | exact standard `L`-kernel near center | `ExactKernelNearCenter` |
| `thm:exact-spectral-coefficient` | exact extraction of isolated spectral coefficient | `exact_spectral_extraction_theorem` |
| `ass:geometric-interpretation-general` | geometric realization of central singularity term | `GeometricRealization` |
| `thm:spec-geom-equality` | spectral-geometric identification | `spec_geom_equality_theorem` / `SpectralGeometricEquality` (`structure`) |
| `ass:bsd-decomposition` | arithmetic BSD-type decomposition | `bsd_decomposition_theorem` / `BSDDecomposition` |
| `thm:GCSF-conditional` | conditional GCSF main theorem | `phaseA_main_theorem` / `GCSFConditional` (`structure`) |

## Proof Replacement Progress (Assumption/Proof State)

| TeX label | Lean anchor | Assumption form | Proof status |
|---|---|---|---|
| `ass:separation` | `SeparationAssumption`, `separation_assumption_theorem` | `structure : Prop` (전칭 + 교차 등식 + consistency 필드) | witness 생성 + `RegularChain`/`MainChain`에서 필드 소비 |
| `lem:diff-spectral` | `diff_spectral_bridge_theorem` | `structure : Prop` (인덱스 안정 + 스칼라 교차 등식) | witness 생성(`diff_spectral_bridge_from_separation`) + `SeparationAssumption` 필드 소비 |
| `lem:finite-orbits` | `finite_regular_orbit_support_theorem` | `structure : Prop` (인덱스 witness + support scalar compatibility + 목록 안정식) | witness 생성(`finite_regular_orbit_support_from_separation`) + `SeparationAssumption` 필드 소비 |
| `lem:analytic-oi` | `analytic_regular_orbit_dependence_theorem` | `structure : Prop` (인덱스 안정 + 스칼라 교차 등식) | witness 생성(`analytic_regular_orbit_dependence_from_separation`) + `SeparationAssumption` 필드 소비 |
| `prop:moment-vanishing` | `moment_vanishing_theorem` | `structure : Prop` (인덱스 안정 + 스칼라 교차 등식) | witness 생성(`moment_vanishing_from_separation`) + `SeparationAssumption` 필드 소비 |
| `prop:termwise-vanish` | `termwise_vanishing_from_inputs` | `structure : Prop` (analytic/moment/separation 입력 필드) | witness 생성 + `RegularChain`에서 필드 소비 |
| `prop:regular-vanishing` | `orbitwise_vanishing_theorem` | `structure : Prop` (indexed/aggregate/orbitwise 래핑 필드) | witness 생성(`orbitwise_vanishing_from_termwise_and_separation`) + `SeparationAssumption` 전달 경로 소비 |
| `thm:Dr-kills-regular` | `regular_annihilation_theorem` | composed from regular chain | composed theorem |
| `thm:GCSF-well-defined` | `WellDefinedA`, `well_definedA_theorem` | `structure : Prop` (계수/도함수 교차 등식 + consistency 필드) | witness 생성 + `Geometric/Main`에서 필드 소비 |
| `ass:isolating-test` | `IsolatingTestExists`, `isolating_test_exists_theorem` | `structure : Prop` (전칭 + 교차 등식 + center consistency 필드) | witness 생성 + `Spectral/Main`에서 필드 소비 |
| `ass:exact-kernel` | `ExactKernelNearCenter`, `exact_kernel_near_center_theorem` | `structure : Prop` (중심값 + 전차수 교차 등식 + consistency 필드) | witness 생성 + `Spectral/Main`에서 필드 소비 |
| `thm:exact-spectral-coefficient` | `exact_spectral_extraction_theorem` | composed from spectral internals | composed theorem |
| `ass:geometric-interpretation-general` | `GeometricRealization`, `geometric_realization_theorem` | `structure : Prop` (계수/도함수 교차 등식 + consistency 필드) | witness 생성 + `Geometric/Main`에서 필드 소비 |
| `thm:spec-geom-equality` | `spec_geom_equality_theorem` | `structure : Prop` (합의 노드 + 최종 동일성 필드) | witness 생성 + `GeometricChain`에서 필드 소비 |
| `ass:bsd-decomposition` | `BSDDecomposition`, `bsd_decomposition_theorem` | `structure : Prop` (계수/도함수 교차 등식 + consistency 필드) | witness 생성 + `Main`에서 필드 소비 |
| `thm:GCSF-conditional` | `phaseA_main_theorem` | `structure : Prop` (스펙트럴/합치/BSD 입력 + 최종 동일성 필드) | witness 생성 + `MainChain`에서 필드 소비 |

## Regular Proof Replacement Progress

| Regular-chain item | Current status | Lean target |
|---|---|---|
| packaged regular input (7 fields) | theorem-backed (separation-derived; diff/finite/analytic/moment/termwise/aggregate/orbitwise) | `RegularChainInput`, `regular_chain_input_from_separation`, `regular_chain_input_theorem`, `regular_annihilation_from_chain_input` |
| differentiability bridge | theorem-backed (separation-derived) | `diff_spectral_bridge_theorem` / `diff_spectral_bridge_from_separation` |
| finite-orbit support | theorem-backed (separation-derived) | `finite_regular_orbit_support_theorem` / `finite_regular_orbit_support_from_separation` |
| analytic orbit dependence | theorem-backed (separation-derived) | `analytic_regular_orbit_dependence_theorem` / `analytic_regular_orbit_dependence_from_separation` |
| moment vanishing | theorem-backed (separation-derived) | `moment_vanishing_theorem` / `moment_vanishing_from_separation` |
| termwise -> indexed vanishing | theorem-backed (index membership + index scalar compatibility field 구성) | `termwise_to_indexed_vanishing` / `index_vanishing_from_termwise_and_membership` |
| indexed finite aggregation | theorem-backed (aggregated consistency + witness-read helper 추가) | `indexed_aggregation` / `aggregate_scalar_from_witness` |
| aggregate -> orbitwise vanishing | theorem-backed (aggregated scalar/consistency 직접 승격 + finite-support witness 소비, separation-routed wrapper 포함) | `aggregate_to_orbitwise` / `orbitwise_vanishing_from_termwise_and_separation` |

## Global Assumption Replacement Progress

| Global assumption item | Current status | Lean target |
|---|---|---|
| well-defined normalized invariant | theorem-backed | `well_definedA_theorem` |
| BSD decomposition | theorem-backed | `bsd_decomposition_theorem` |
| general Kudla identity | theorem-backed (coeff/deriv + consistency field) | `general_kudla_identity_theorem` |

## Packaged Phase A Interfaces

| Interface | Lean declaration |
|---|---|
| phase-A packaged witness bundle (explicit fields + theorem-backed defaults) | `PhaseAInput` |
| phase-A input constructors | `phaseA_input`, `phaseA_input_default`, `phaseA_input_reduced` |
| phase-A regular/input consistency bridge | `phaseA_regular_chain_consistency`, `phaseA_regular_from_input` |
| phase-A assumption snapshot | `phaseA_assumption_snapshot_from_input`, `phaseA_assumption_snapshot_reduced` |
| regular-chain packaged input (7 fields) | `RegularChainInput`, `regular_chain_input_from_separation`, `regular_chain_input_theorem` |
| packaged conditional theorem | `phaseA_main_theorem_from_input` |
| packaged regular + main theorem | `phaseA_regular_then_main` |
| reduced regular + main wrapper | `phaseA_regular_then_main_reduced` |
| packaged dependency snapshot | `phaseA_dependency_snapshot_from_input` |
| reduced dependency snapshot wrapper | `phaseA_dependency_snapshot_reduced` |
| packaged expanded snapshot | `phaseA_expanded_snapshot_from_input` |
| reduced expanded snapshot wrapper | `phaseA_expanded_snapshot_reduced` |
| reduced-input conditional wrapper | `phaseA_main_theorem_reduced` |

## Packaged Phase B Interfaces

| Interface | Lean declaration |
|---|---|
| phase-B aggregated assumptions | `PhaseBInput` (`phaseA`, `kudlaInput`) |
| phase-B assumption snapshot bundle | `PhaseBAssumptionSnapshot`, `phaseB_assumption_snapshot_from_input`, `phaseB_assumption_snapshot_reduced` |
| phase-B input constructors | `phaseB_input`, `phaseB_input_from_phaseA` (explicit Kudla), `phaseB_input_from_phaseA_default` (theorem-backed Kudla), `phaseB_input_reduced` |
| Kudla + conditional wrapper | `phaseB_main_with_kudla` / `phaseB_main_with_kudla_from_input` |
| regular extraction from packaged Phase B input | `phaseB_regular_from_input` |
| regular+conditional snapshot from packaged Phase B input | `phaseB_result_snapshot_from_input`, `phaseB_result_snapshot_reduced` |
| Phase-A + Kudla explicit wrapper | `phaseB_main_with_kudla_from_phaseA` |
| Phase-A + Kudla default wrapper | `phaseB_main_with_kudla_from_phaseA_default` |
| reduced-input Kudla + conditional wrapper | `phaseB_main_with_kudla_reduced` |
| regular annihilation + Kudla + conditional | `phaseB_regular_then_main` |
| Phase-A + Kudla explicit regular/main wrapper | `phaseB_regular_then_main_from_phaseA` |
| Phase-A + Kudla default regular/main wrapper | `phaseB_regular_then_main_from_phaseA_default` |
| reduced-input regular annihilation + Kudla + conditional | `phaseB_regular_then_main_reduced` |
| low-rank anchor (`prop:r0`) | `low_rank_prop_r0` |
| low-rank chain (`prop:r1-chain`) | `low_rank_prop_r1_chain` |
| low-rank expanded snapshot | `low_rank_snapshot` |
| explicit low-rank wrappers | `low_rank_prop_r0_from_phaseA`, `low_rank_prop_r1_chain_from_phaseA`, `low_rank_snapshot_from_phaseA` |
| default low-rank wrappers | `low_rank_prop_r0_from_phaseA_default`, `low_rank_prop_r1_chain_from_phaseA_default`, `low_rank_snapshot_from_phaseA_default` |
| reduced low-rank wrappers | `low_rank_prop_r0_reduced`, `low_rank_prop_r1_chain_reduced`, `low_rank_snapshot_reduced` |
| Kudla intermediate lemmas | `phaseB_kudla_intermediate`, `kudla_arithmetic_identity`, `kudla_derivative_identity`, `kudla_consistency_identity`, `kudla_assumption_from_input`, `kudla_assumption_from_phaseA`, `kudla_assumption_from_phaseA_default`, `kudla_regular_bridge`, `kudla_regular_from_input`, `kudla_regular_from_phaseA`, `kudla_regular_from_phaseA_default`, `kudla_conditional_bridge`, `phaseB_conditional_from_input`, `kudla_conditional_from_phaseA`, `kudla_conditional_from_phaseA_default`, `kudla_phaseB_snapshot`, `isolating_test_from_conditional`, `exact_kernel_from_conditional`, `geometric_realization_from_conditional`, `central_derivative_from_conditional`, `kudla_isolating_kernel_data`, `kudla_geometric_data`, `kudla_exact_spectral_data`, `kudla_isolating_kernel_data_from_conditional`, `kudla_geometric_data_from_conditional`, `kudla_exact_spectral_data_from_conditional`, `central_parameterization_of_kudla`, `kill_other_pi_of_kudla`, `geometric_independence_of_kudla`, `exact_spectral_extraction_of_kudla`, `singular_as_height_cm_of_kudla` |
| Kudla explicit/default/reduced snapshots | `kudla_phaseB_snapshot_from_phaseA`, `kudla_phaseB_snapshot_from_phaseA_default`, `kudla_phaseB_snapshot_reduced` |
| follow-up core combiner | `phaseB_followup_snapshot_from_kudla_and_conditional` |
| follow-up snapshot over connected post-main labels | `phaseB_followup_snapshot`, `phaseB_followup_snapshot_from_phaseA`, `phaseB_followup_snapshot_from_phaseA_default`, `phaseB_followup_snapshot_reduced` |

## Connected Follow-up Labels (Phase B)

| TeX label | Lean declaration |
|---|---|
| `ass:general-kudla-identity` | `general_kudla_identity_theorem`, `GeneralKudlaIdentity`, `phaseB_main_with_kudla_reduced` |
| `thm:geometric-interpretation-established` | `geometric_realization_of_established_case` |
| `prop:r0` | `low_rank_prop_r0` |
| `prop:r1-chain` | `low_rank_prop_r1_chain` |
| `prop:central-parameterization` | `CentralParameterization` (`structure`), `central_parameterization_theorem` |
| `prop:geom-independence` | `GeometricIndependence` (`structure`), `geometric_independence_theorem` |
| `prop:independence-family` | `IndependenceFamily` (`structure`), `independence_family_theorem` |
| `prop:kill-other-pi` | `KillOtherPi` (`structure`), `kill_other_pi_theorem` |
| `prop:spectral-interpretation` | `SpectralInterpretation` (`structure`), `spectral_interpretation_theorem` |
| `thm:regulator` | `RegulatorStatement` (`structure`), `regulator_theorem` |
| `thm:selmer-rank` | `SelmerRankStatement` (`structure`), `selmer_rank_theorem` |
| `thm:singular-as-height-CM` | `SingularAsHeightCM` (`structure`), `singular_as_height_cm_theorem` |

## Follow-up Proof Replacement Progress (Assumption/Proof State)

| TeX label | Lean anchor | Assumption form | Proof status |
|---|---|---|---|
| `prop:central-parameterization` | `central_parameterization_theorem` | `structure : Prop` (isolation/kernel 입력 + 동일성 필드) | witness 생성 + `kudla_isolating_kernel_data_from_conditional`(= `GCSFConditional` 추출 입력 + Kudla derivative) 경유 조립 |
| `prop:kill-other-pi` | `kill_other_pi_theorem` | `structure : Prop` (isolation 입력 + 동일성 필드) | witness 생성 + `kudla_isolating_kernel_data_from_conditional` 경유 조립 |
| `prop:geom-independence` | `geometric_independence_theorem` | `structure : Prop` (geometric 입력 + 동일성 필드) | witness 생성 + `kudla_geometric_data_from_conditional` 경유 조립 |
| `prop:independence-family` | `independence_family_theorem` | `structure : Prop` (geom-independence 입력 + 동일성 필드) | witness 생성 + `FollowupChain`에서 필드 소비 |
| `prop:spectral-interpretation` | `spectral_interpretation_theorem` | `structure : Prop` (exact-spectral 입력 + 동일성 필드) | witness 생성 + `kudla_exact_spectral_data_from_conditional` 경유 exact-spectral 입력 소비 |
| `thm:selmer-rank` | `selmer_rank_theorem` | `structure : Prop` (conditional 입력 + 동일성 필드) | witness 생성 + `FollowupChain`에서 필드 소비 |
| `thm:regulator` | `regulator_theorem` | `structure : Prop` (conditional 입력 + 동일성 필드) | witness 생성 + `FollowupChain`에서 필드 소비 |
| `thm:singular-as-height-CM` | `singular_as_height_cm_theorem` | `structure : Prop` (geometric 입력 + 동일성 필드) | witness 생성 + `kudla_geometric_data_from_conditional` 경유 조립 |

## Backlog Labels (Phase C+)

Currently empty (`phaseCBacklogTexLabels = []`).

## Established-case Route (Optional)

| Route step | Lean declaration |
|---|---|
| established-case input | `EstablishedCaseInput` (`structure`) |
| established interpretation node | `established_case_interpretation_from_input` / `GeometricInterpretationEstablished` (`structure`) |
| established -> general geometric realization | `established_to_general_realization_from_interpretation` / `geometric_realization_of_established_case` |
| conditional main theorem (established route) | `phaseA_main_theorem_established_case` |

## Spectral-Geometric Agreement Internals

| Internal step | Lean declaration |
|---|---|
| spectral package node | `SpectralCentralPackage` (`structure`) |
| geometric package node | `GeometricCentralPackage` (`structure`) |
| spectral normalization | `spectral_normalization_from_package` / `SpectralInvariantNormalization` (`structure`) |
| geometric normalization | `geometric_normalization_from_package` / `GeometricInvariantNormalization` (`structure`) |
| normalization match data | `normalization_match_data` / `NormalizationMatchData` (`structure`) |
| common-invariant certificate | `common_invariant_certificate_of_match` / `CommonInvariantCertificate` (`structure`) |
| common invariant assembly | `common_invariant_from_certificate` / `CommonCentralInvariant` (`structure`) |
| common invariant -> agreement | `central_agreement_theorem` / `CentralSingularityAgreement` (`structure`) |

## Regular Aggregation Internals

| Internal step | Lean declaration |
|---|---|
| witness index list | `regular_orbit_indices` |
| termwise -> indexed vanishing | `termwise_to_indexed_vanishing`, `index_vanishing_from_termwise_and_membership` (index membership + index scalar compatibility field 구성) |
| indexed finite aggregation | `indexed_aggregation`, `aggregate_scalar_from_witness` (aggregated witness + aggregated scalar compatibility + aggregated consistency field 구성) |
| aggregate -> orbitwise vanishing | `aggregate_to_orbitwise`, `orbitwise_vanishing_from_termwise_and_separation` (aggregated scalar/consistency를 orbitwise scalar/consistency로 직접 승격, finite-support witness 동시 소비) |

## Spectral Extraction Internals

| Internal step | Lean declaration |
|---|---|
| local isolation | `local_isolation_data_from_exists` / `LocalIsolatingData` (`structure`) |
| globalization | `global_isolation_from_local` / `GlobalIsolatingPackage` (`structure`) |
| isolated coefficient extraction | `isolated_coefficient_from_global` / `IsolatedSpectralCoefficient` (`structure`) |
| kernel adjustment | `kernel_adjustment_from_kernel_and_isolated` / `KernelAdjustedSpectralPackage` (`structure`) |
| derivative normalization | `derivative_normalization_from_kernel_adjusted` / `SpectralDerivativeNormalization` (`structure`) |
| central derivative packaging | `central_derivative_package_from_normalization` / `CentralDerivativePackage` (`structure`) |
| exact extraction bridge | `exact_extraction_from_package` / `ExactSpectralExtraction` (`structure`) |
