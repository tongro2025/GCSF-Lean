# GCSF Lean 프로젝트 결론 요약

작성일: `2026-02-22`

## 1) 프로그램 실행 결과
- 실행 명령: `lake exe gcsflean`
- 표준 출력:
  - `GCSF Lean scaffold ready`
- 결론: 실행 파일(`gcsflean`)은 정상 생성 및 실행된다.

## 2) 빌드/환경 결론
- Lean/Lake 제약 해소:
  - 로컬 툴체인 경로: `.tooling/elan`
  - 설치 툴체인: `leanprover/lean4:v4.27.0`
- 빌드 결과:
  - 명령: `lake build`
  - 결과: `Build completed successfully (32 jobs).`
- 결론: 현재 저장소는 재현 가능한 로컬 Lean 빌드가 가능하다.

## 3) 형식화(TeX -> Lean) 상태 결론
- `axiom` 선언 수:
  - `0`개 (`rg '^axiom ' GCSF --glob '*.lean'` 기준)
- Lean 선언(스캐폴드) 수:
  - 총 `209`개 (`abbrev/theorem/def/structure/opaque` 정규식 집계)
  - 세부: `abbrev 0`, `theorem 139`, `def 14`, `structure 48`, `opaque 8`
- “선언 수가 0”으로 보이는 경우의 해석:
  - 해당 값은 전체 선언 수가 아니라 `axiom` 카운트(`0`)를 의미한다.
- TeX 라벨 추적:
  - TeX 총 라벨: `77`
  - Phase A core 라벨: `16` (누락 0)
  - Phase B follow-up 라벨: `12` (누락 0)
  - 미연결 핵심(`ass:/lem:/prop:/thm:`) 라벨: `0`
- 결론: 현재 스캐폴드 범위에서 핵심 라벨은 Lean 선언/정리로 모두 연결됐다.

## 4) 구조적 결론
- Phase A/Phase B 입력 패키지화 완료:
  - `PhaseAInput`, `PhaseBInput`
  - `PhaseAInput`은 `separation/well/isolating/exact-kernel/geometric/BSD` + `regularChainInput`(7-field regular package) 필드를 보유하며, 각 필드에 theorem-backed default witness가 연결됨
  - `phaseA_input`/`phaseA_input_default`/`phaseA_input_reduced` 생성자가 추가되어 explicit/default/reduced Phase A 입력 경로가 분리됨
  - `PhaseBAssumptionSnapshot` + `phaseB_assumption_snapshot_from_input`/`phaseB_assumption_snapshot_reduced`가 추가되어 Phase B 가정 묶음을 Type-level snapshot으로 분리 노출함
  - `PhaseBInput`은 `phaseA`와 `kudlaInput : GeneralKudlaIdentity E r`를 함께 보유하며, `phaseB_main_with_kudla_from_input`/`phaseB_regular_then_main`이 이 필드를 직접 소비함
  - `phaseB_input`/`phaseB_input_from_phaseA`(explicit Kudla)/`phaseB_input_from_phaseA_default`(theorem-backed Kudla)/`phaseB_input_reduced` 생성자가 추가되어 explicit 경로와 default scaffold 경로가 분리됨
- 핵심 정리 체인:
  - `phaseA_main_theorem` 및 input-wrapper들
  - `phaseA_regular_chain_consistency`/`phaseA_regular_from_input`로 packaged regular 경로의 정합성과 직접 추출 경로를 분리
  - `phaseA_assumption_snapshot_from_input`/`phaseA_assumption_snapshot_reduced`로 Phase A 상위 가정 번들을 snapshot 정리로 노출
  - reduced Phase A wrappers: `phaseA_regular_then_main_reduced`, `phaseA_dependency_snapshot_reduced`, `phaseA_expanded_snapshot_reduced`
  - `phaseB_regular_from_input`/`phaseB_result_snapshot_from_input`/`phaseB_result_snapshot_reduced`를 추가해 packaged Phase B 입력에서 정규/주정리 결과 추출 경로를 분리
  - `phaseB_main_with_kudla`, `phaseB_regular_then_main`
  - explicit/default wrappers: `phaseB_main_with_kudla_from_phaseA`/`phaseB_main_with_kudla_from_phaseA_default`, `phaseB_regular_then_main_from_phaseA`/`phaseB_regular_then_main_from_phaseA_default`
- 가정 구조체 필드 소비 연결:
  - `RegularChain`에서 `DiffSpectralBridge`/`FiniteRegularOrbitSupport`/`AnalyticRegularOrbitDependence`/`MomentVanishing` 필드 사용
  - `RegularChain`/`MainChain`에서 `SeparationAssumption`의 finite/test-family + consistency 필드 사용
  - `GeometricChain`/`MainChain`에서 `WellDefinedA`의 coeff/deriv + consistency 필드 사용
  - `SpectralChain`/`MainChain`에서 `IsolatingTestExists`/`ExactKernelNearCenter`/`BSDDecomposition`의 consistency 포함 필드 사용
  - `GeometricChain`/`MainChain`/`FollowupChain`에서 `GeometricRealization`/`GeneralKudlaIdentity` 필드 사용
- 스펙트럴 추출 내부 노드 구조화:
  - `LocalIsolatingData`~`ExactSpectralExtraction`이 `structure : Prop`로 승격되고 `SpectralChain`에서 조립/소비됨
- 스펙트럴-기하 합치 내부 노드 구조화:
  - `SpectralInvariantNormalization`/`GeometricInvariantNormalization`/`NormalizationMatchData`/`CommonInvariantCertificate`/`CommonCentralInvariant`/`CentralSingularityAgreement`/`SpectralGeometricEquality`이 `structure : Prop`로 승격되고 `AgreementChain`/`GeometricChain`에서 조립/소비됨
- 최종 조건 정리 구조화:
  - `GCSFConditional`이 `structure : Prop`로 승격되고 `MainChain`에서 조립/소비됨
- 저차수/후속 라벨 체인 확장:
  - `LowRankChain`: `prop:r0`, `prop:r1-chain`
  - `FollowupChain`: `prop:central-parameterization`, `prop:kill-other-pi`, `prop:geom-independence`, `prop:independence-family`, `prop:spectral-interpretation`, `thm:selmer-rank`, `thm:regulator`, `thm:singular-as-height-CM`이 모두 `structure : Prop` 인터페이스로 정리됨
  - explicit/default/reduced wrapper 확장: `phaseB_regular_then_main_reduced`, `low_rank_prop_r0_from_phaseA`/`low_rank_prop_r0_from_phaseA_default`/`low_rank_prop_r0_reduced`, `low_rank_prop_r1_chain_from_phaseA`/`low_rank_prop_r1_chain_from_phaseA_default`/`low_rank_prop_r1_chain_reduced`, `low_rank_snapshot_from_phaseA`/`low_rank_snapshot_from_phaseA_default`/`low_rank_snapshot_reduced`, `kudla_phaseB_snapshot_from_phaseA`/`kudla_phaseB_snapshot_from_phaseA_default`/`kudla_phaseB_snapshot_reduced`, `phaseB_followup_snapshot_from_phaseA`/`phaseB_followup_snapshot_from_phaseA_default`/`phaseB_followup_snapshot_reduced`
- 정규/중간 패키지 인터페이스 추가 구조화:
  - `TermwiseVanishingOnRegularOrbits`/`RegularOrbitIndexVanishes`/`RegularOrbitAggregateVanishes`/`OrbitwiseRegularVanishing`/`RegularOrbitVanishing`/`RegularTermsAnnihilated`가 `structure : Prop`로 전환됨
  - `RegularChainInput`(7-field: diff/finite/analytic/moment/termwise/aggregate/orbitwise)이 추가되어 `regular_chain_input_from_separation` -> `regular_annihilation_from_chain_input` 경로로 실제 증명 조립이 패키지화됨
  - `EstablishedCaseInput`/`GeometricInterpretationEstablished`와 `SpectralCentralPackage`/`GeometricCentralPackage`도 `structure : Prop`로 전환됨
- 증명 스타일 정리:
  - 체인 레벨 정리들(`Spectral/Agreement/Geometric/Main/Followup/Established`)의 `scalar_eq` 호출이 제거되고, 기존 필드/대칭(`Eq.symm`) 기반 연결로 정리됨
  - 전역 witness 정리(`well_definedA`/`geometric_realization`/`bsd_decomposition`/`general_kudla_identity`/`separation`/`isolating_test`/`exact_kernel`)는 기본 항등식을 중심으로 `symm`/`rfl`로 consistency를 구성하는 형태로 정리되어 중복 case-split이 축소됨
- 정규 코어 가정 의존성 강화:
  - `diff_spectral_bridge_from_separation`/`finite_regular_orbit_support_from_separation`/`analytic_regular_orbit_dependence_from_separation`/`moment_vanishing_from_separation`를 추가하고
  - `orbitwise_vanishing_from_termwise_and_separation`를 통해 핵심 정규 사슬의 집계 단계까지 `SeparationAssumption` 전달 경로를 유지하도록 보강됨
  - `RegularOrbitAggregateVanishes`/`OrbitwiseRegularVanishing`의 scalar-compatibility 필드가 `indexed_aggregation`/`aggregate_to_orbitwise`에서 채워지도록 강화됨
  - `RegularOrbitIndexVanishes`도 `indexMembership` + `indexScalarCompatibility` 필드를 갖도록 강화되어 `termwise_to_indexed_vanishing`이 index-level 제약을 직접 구성함
  - `RegularOrbitAggregateVanishes`/`OrbitwiseRegularVanishing`에 consistency 필드가 추가되어 witness 기반 스칼라 항등과 저장된 scalar-compatibility 필드의 정합성이 명시됨 (`aggregate_scalar_from_witness` 보조정리 추가)
  - 최근 리팩터링에서 `aggregate_to_orbitwise`는 aggregated scalar/consistency 필드를 orbitwise 필드로 직접 승격하고, `FiniteRegularOrbitSupport`는 finite-support witness 소비로 유지함
- Phase B Kudla 의존성 강화:
  - `GeneralKudlaIdentity`에 `compatibilityConsistency` 필드가 추가되어 `arithmeticGeometricCompatibility`/`derivativeCompatibility` 사이의 정합성이 구조체 수준에서 명시됨
  - `phaseB_kudla_intermediate`를 추가해 Phase B에서 Kudla coeff/deriv/consistency payload를 중간 보조정리로 분리하고, `kudla_arithmetic_identity`/`kudla_derivative_identity`/`kudla_consistency_identity`가 이를 재사용하도록 정리함
  - `isolating_test_from_conditional`/`exact_kernel_from_conditional`/`geometric_realization_from_conditional`/`central_derivative_from_conditional`을 추가해 `GCSFConditional`에서 후속 입력 witness를 직접 추출하는 경로를 명시화함
  - `kudla_isolating_kernel_data_from_conditional`/`kudla_geometric_data_from_conditional`/`kudla_exact_spectral_data_from_conditional`을 추가해 후속 정리 입력을 `(conditional 추출 witness) + (Kudla 필드)` 조합으로 조립하도록 강화함
  - `kudla_isolating_kernel_data`/`kudla_geometric_data`/`kudla_exact_spectral_data`는 위 conditional 추출 경로를 재사용하도록 리팩터링됨
  - `phaseB_conditional_from_input`/`kudla_regular_from_input` + `kudla_*_from_phaseA`/`kudla_*_from_phaseA_default`를 추가해 입력/explicit/default 투영 기반 조립 경로를 명시화함
  - `phaseB_followup_snapshot_from_kudla_and_conditional` 코어 조립기를 추가하고, `phaseB_followup_snapshot`/`phaseB_followup_snapshot_from_phaseA`/default/reduced 래퍼들이 이를 재사용하도록 정리함
  - 최신 리팩터링에서 reduced 경로는 `*_from_phaseA_default`를 재사용하도록 정리되어, explicit 경로(`*_from_phaseA`)와 theorem-backed default 경로가 계층적으로 분리됨

## 5) 해석상 최종 판단
- 이 프로젝트는 **완전 증명본**이 아니라, TeX 논리 흐름을 Lean 타입/정리 인터페이스로 고정한 **검증 가능한 형식화 스캐폴드**다.
- 공리 키워드는 제거되었고(`axiom = 0`), 핵심 가정군은 theorem-backed witness 경로로 전환되었다.
- `PhaseAInput`은 단순 token이 아니라 가정 witness 번들(`separation/well/isolating/exact-kernel/geometric/BSD` + `regularChainInput`)로 정리되었고, 기본값은 theorem-backed witness로 제공된다.
- 핵심 가정/정의 7개(`WellDefinedA` 포함 `Separation/Isolating/ExactKernel/Geometric/Kudla/BSD`)는 `structure : Prop`로 승격되었고, 필드는 `A`/`LambdaDeriv` 교차 등식 + 전칭 명제 + consistency 제약 기반 scaffold로 구체화되었다.
- 현재 `abbrev` 선언은 0개이며, 타입 별칭(`Scalar`, `RankIndex`)도 `def`로 정리되었다.
- 다만 아직 내용적 제약(실질 수학 명제)은 약하므로 다음 단계에서 강화가 필요하다.
- 따라서 현재 단계의 의미는:
  - “논리 경로와 의존성 그래프가 Lean에서 일관되게 컴파일됨”을 보장
  - “분석/산술 실증명”은 다음 단계에서 교차 등식 기반 scaffold를 실질 제약 명제로 대체하는 방식으로 진행

## 6) 다음 우선순위(권장)
1. 정규 사슬 핵심 정리(`diff/finite/analytic/moment`)의 theorem-backed 상태를 유지하고, 수학적 내용 증명으로 강화.
2. `WellDefinedA`, `SeparationAssumption`, `IsolatingTestExists`, `ExactKernelNearCenter`, `GeometricRealization`, `GeneralKudlaIdentity`, `BSDDecomposition`의 교차 등식/전칭 필드를 내용 있는 제약으로 교체.
3. `GeneralKudlaIdentity` 기반 중간 data lemma(`kudla_isolating_kernel_data` 등)는 추가 완료. 다음으로 theorem-backed 글로벌 witness(`isolating_test_exists_theorem`/`exact_kernel_near_center_theorem`/`geometric_realization_theorem`) 자체를 내용 있는 제약으로 교체해 Phase B 의존성을 실질 수학 명제로 강화.
4. `TEX_TO_LEAN_INVENTORY.md` 진행률 표를 단계별(가정/부분증명/완료)로 유지하고, theorem-backed 항목의 실증명 전환 상태를 추적.
