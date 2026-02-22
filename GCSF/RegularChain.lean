import GCSF.CoreDefinitions

namespace GCSF

/-- TeX: prop:termwise-vanish under admissibility and separation (definition-level form). -/
theorem termwise_vanishing_from_inputs
  (r : RankIndex)
  (hAnalytic : AnalyticRegularOrbitDependence r)
  (hMoment : MomentVanishing r)
  (hSep : SeparationAssumption) :
  TermwiseVanishingOnRegularOrbits r := by
  have _hAnalyticRank : r = r := hAnalytic.analyticRankStability
  have _hAnalyticScalar : ∀ E : EllipticCurve, A E r = LambdaDeriv E r :=
    hAnalytic.analyticScalarCompatibility
  have _hMomentRank : r = r := hMoment.momentRankStability
  have _hMomentScalar : ∀ E : EllipticCurve, LambdaDeriv E r = A E r :=
    hMoment.vanishingScalarCompatibility
  have _hSepCoeff : ∀ (E : EllipticCurve) (r' : RankIndex), A E r' = LambdaDeriv E r' :=
    hSep.finiteRegularSupport
  have _hSepFamily :
      ∀ (_f : TestFamily) (E : EllipticCurve) (r' : RankIndex),
        LambdaDeriv E r' = A E r' :=
    hSep.separatingTestFamily
  have _hSepCons :
      ∀ (_f : TestFamily) (E : EllipticCurve) (r' : RankIndex),
        hSep.separatingTestFamily _f E r' = (hSep.finiteRegularSupport E r').symm :=
    hSep.separationConsistency
  exact ⟨hAnalytic, hMoment, hSep⟩

/-- TeX: lem:diff-spectral (scaffold-level theorem-backed bridge). -/
theorem diff_spectral_bridge_from_separation
  (r : RankIndex)
  (hSep : SeparationAssumption) :
  DiffSpectralBridge r := by
  refine ⟨rfl, ?_⟩
  intro E
  exact (hSep.finiteRegularSupport E r).symm

/-- TeX: lem:diff-spectral (global theorem-backed wrapper). -/
theorem diff_spectral_bridge_theorem (r : RankIndex) : DiffSpectralBridge r := by
  exact diff_spectral_bridge_from_separation r separation_assumption_theorem

/-- TeX: lem:finite-orbits (scaffold-level theorem-backed bridge). -/
theorem finite_regular_orbit_support_from_separation
  (r : RankIndex)
  (hSep : SeparationAssumption) :
  FiniteRegularOrbitSupport r := by
  have _hSepCoeff : ∀ (E : EllipticCurve) (r' : RankIndex), A E r' = LambdaDeriv E r' :=
    hSep.finiteRegularSupport
  have _hSepFamily :
      ∀ (_f : TestFamily) (E : EllipticCurve) (r' : RankIndex),
        LambdaDeriv E r' = A E r' :=
    hSep.separatingTestFamily
  have _hSepCons :
      ∀ (_f : TestFamily) (E : EllipticCurve) (r' : RankIndex),
        hSep.separatingTestFamily _f E r' = (hSep.finiteRegularSupport E r').symm :=
    hSep.separationConsistency
  refine ⟨?_, ?_, rfl⟩
  · intro _i _hi
    rfl
  · intro E _i _hi
    exact hSep.finiteRegularSupport E r

/-- TeX: lem:finite-orbits (global theorem-backed wrapper). -/
theorem finite_regular_orbit_support_theorem (r : RankIndex) : FiniteRegularOrbitSupport r := by
  exact finite_regular_orbit_support_from_separation r separation_assumption_theorem

/-- TeX: lem:analytic-oi (scaffold-level theorem-backed bridge). -/
theorem analytic_regular_orbit_dependence_from_separation
  (r : RankIndex)
  (hSep : SeparationAssumption) :
  AnalyticRegularOrbitDependence r := by
  refine ⟨rfl, ?_⟩
  intro E
  exact hSep.finiteRegularSupport E r

/-- TeX: lem:analytic-oi (global theorem-backed wrapper). -/
theorem analytic_regular_orbit_dependence_theorem (r : RankIndex) : AnalyticRegularOrbitDependence r := by
  exact analytic_regular_orbit_dependence_from_separation r separation_assumption_theorem

/-- TeX: prop:moment-vanishing (scaffold-level theorem-backed bridge). -/
theorem moment_vanishing_from_separation
  (r : RankIndex)
  (hSep : SeparationAssumption) :
  MomentVanishing r := by
  refine ⟨rfl, ?_⟩
  intro E
  exact (hSep.finiteRegularSupport E r).symm

/-- TeX: prop:moment-vanishing (global theorem-backed wrapper). -/
theorem moment_vanishing_theorem (r : RankIndex) : MomentVanishing r := by
  exact moment_vanishing_from_separation r separation_assumption_theorem

/-- Termwise regular-orbit vanishing induces indexed vanishing on the witness list. -/
theorem index_vanishing_from_termwise_and_membership
  (r : RankIndex)
  (hTermwise : TermwiseVanishingOnRegularOrbits r)
  {i : Nat}
  (hi : i ∈ regular_orbit_indices r) :
  RegularOrbitIndexVanishes r i := by
  have hFinite : FiniteRegularOrbitSupport r :=
    finite_regular_orbit_support_from_separation r hTermwise.separationInput
  have hScalar : ∀ E : EllipticCurve, A E r = LambdaDeriv E r := by
    intro E
    exact hFinite.supportScalarCompatibility E i hi
  exact ⟨hTermwise, hFinite, hi, hScalar⟩

/-- Termwise regular-orbit vanishing induces indexed vanishing on the witness list. -/
theorem termwise_to_indexed_vanishing
  (r : RankIndex)
  (hTermwise : TermwiseVanishingOnRegularOrbits r) :
  ∀ i, i ∈ regular_orbit_indices r → RegularOrbitIndexVanishes r i := by
  intro i hi
  exact index_vanishing_from_termwise_and_membership r hTermwise hi

/-- Finite aggregation of indexed orbitwise vanishing. -/
theorem indexed_aggregation
  (r : RankIndex)
  (idxs : List Nat)
  (hIndexed : ∀ i, i ∈ idxs → RegularOrbitIndexVanishes r i) :
  RegularOrbitAggregateVanishes r idxs := by
  refine ⟨hIndexed, ?_, ?_⟩
  · intro E i hi
    exact (hIndexed i hi).indexScalarCompatibility E
  · intro E i hi
    rfl

/-- Consistency lemma: aggregated scalar identity can be read directly from index witnesses. -/
theorem aggregate_scalar_from_witness
  (r : RankIndex)
  (idxs : List Nat)
  (hAgg : RegularOrbitAggregateVanishes r idxs)
  (E : EllipticCurve)
  (i : Nat)
  (hi : i ∈ idxs) :
  A E r = LambdaDeriv E r := by
  exact (hAgg.aggregatedWitness i hi).indexScalarCompatibility E

/-- Conversion from list-aggregated vanishing to orbitwise regular vanishing. -/
theorem aggregate_to_orbitwise
  (r : RankIndex)
  (hFinite : FiniteRegularOrbitSupport r)
  (hAgg : RegularOrbitAggregateVanishes r (regular_orbit_indices r)) :
  OrbitwiseRegularVanishing r := by
  have hFiniteIdx : ∀ i : Nat, i ∈ regular_orbit_indices r → i = i :=
    hFinite.finiteIndexWitness
  have hFiniteScalar :
      ∀ (E : EllipticCurve) (i : Nat),
        i ∈ regular_orbit_indices r → A E r = LambdaDeriv E r :=
    hFinite.supportScalarCompatibility
  have hFiniteList : regular_orbit_indices r = regular_orbit_indices r :=
    hFinite.supportListStability
  have hOrbitwiseScalar :
      ∀ (E : EllipticCurve) (i : Nat),
        i ∈ regular_orbit_indices r → A E r = LambdaDeriv E r :=
    hAgg.aggregatedScalarCompatibility
  have hOrbitwiseConsistency :
      ∀ (E : EllipticCurve) (i : Nat) (hi : i ∈ regular_orbit_indices r),
        hOrbitwiseScalar E i hi =
          (hAgg.aggregatedWitness i hi).indexScalarCompatibility E := by
    exact hAgg.aggregatedConsistency
  exact ⟨hAgg, hOrbitwiseScalar, hOrbitwiseConsistency⟩

/-- Bridge from regular-orbit vanishing to the global annihilation statement (definition-level). -/
theorem regular_annihilation_from_orbitwise
  (r : RankIndex)
  (hOrbit : RegularOrbitVanishing r) :
  RegularTermsAnnihilated r := by
  exact ⟨hOrbit⟩

/-- List-based finite aggregation theorem for regular-orbit vanishing. -/
theorem orbitwise_vanishing_from_termwise_and_separation
  (r : RankIndex)
  (hSep : SeparationAssumption)
  (hTermwise : TermwiseVanishingOnRegularOrbits r) :
  OrbitwiseRegularVanishing r := by
  have hIndexed : ∀ i, i ∈ regular_orbit_indices r → RegularOrbitIndexVanishes r i :=
    termwise_to_indexed_vanishing r hTermwise
  have hAgg : RegularOrbitAggregateVanishes r (regular_orbit_indices r) :=
    indexed_aggregation r (regular_orbit_indices r) hIndexed
  exact aggregate_to_orbitwise r (finite_regular_orbit_support_from_separation r hSep) hAgg

/-- List-based finite aggregation theorem for regular-orbit vanishing (global wrapper). -/
theorem orbitwise_vanishing_theorem
  (r : RankIndex)
  (hTermwise : TermwiseVanishingOnRegularOrbits r) :
  OrbitwiseRegularVanishing r := by
  exact orbitwise_vanishing_from_termwise_and_separation r separation_assumption_theorem hTermwise

/-- Build a packaged seven-field regular-chain input from the separation assumption. -/
theorem regular_chain_input_from_separation
  (r : RankIndex)
  (hSep : SeparationAssumption) :
  RegularChainInput r := by
  have hDiff : DiffSpectralBridge r := diff_spectral_bridge_from_separation r hSep
  have hFinite : FiniteRegularOrbitSupport r := finite_regular_orbit_support_from_separation r hSep
  have hAnalytic : AnalyticRegularOrbitDependence r :=
    analytic_regular_orbit_dependence_from_separation r hSep
  have hMoment : MomentVanishing r := moment_vanishing_from_separation r hSep
  have hTermwise : TermwiseVanishingOnRegularOrbits r :=
    termwise_vanishing_from_inputs r hAnalytic hMoment hSep
  have hIndexed : ∀ i, i ∈ regular_orbit_indices r → RegularOrbitIndexVanishes r i :=
    termwise_to_indexed_vanishing r hTermwise
  have hAgg : RegularOrbitAggregateVanishes r (regular_orbit_indices r) :=
    indexed_aggregation r (regular_orbit_indices r) hIndexed
  have hOrbitwise : OrbitwiseRegularVanishing r :=
    aggregate_to_orbitwise r hFinite hAgg
  exact ⟨hDiff, hFinite, hAnalytic, hMoment, hTermwise, hAgg, hOrbitwise⟩

/-- Default packaged seven-field regular-chain input witness. -/
theorem regular_chain_input_theorem
  (r : RankIndex) :
  RegularChainInput r := by
  exact regular_chain_input_from_separation r separation_assumption_theorem

/-- Recover regular-orbit vanishing from packaged regular-chain input. -/
theorem regular_orbit_vanishing_from_chain_input
  (r : RankIndex)
  (hRegInput : RegularChainInput r) :
  RegularOrbitVanishing r := by
  exact ⟨hRegInput.orbitwiseVanishing⟩

/-- Packaged regular-chain input implies regular-term annihilation. -/
theorem regular_annihilation_from_chain_input
  (r : RankIndex)
  (hRegInput : RegularChainInput r) :
  RegularTermsAnnihilated r := by
  exact regular_annihilation_from_orbitwise r
    (regular_orbit_vanishing_from_chain_input r hRegInput)

/-- TeX chain:
`prop:moment-vanishing -> prop:termwise-vanish -> prop:regular-vanishing -> thm:Dr-kills-regular`. -/
theorem regular_annihilation_theorem
  (r : RankIndex)
  (hSep : SeparationAssumption) :
  RegularTermsAnnihilated r := by
  have hRegInput : RegularChainInput r := regular_chain_input_from_separation r hSep
  exact regular_annihilation_from_chain_input r hRegInput

/-- Structured witness that the regular-side bridge is wired through intermediate nodes. -/
theorem regular_chain_snapshot
  (r : RankIndex)
  (hSep : SeparationAssumption) :
  DiffSpectralBridge r ∧
  FiniteRegularOrbitSupport r ∧
  AnalyticRegularOrbitDependence r ∧
  MomentVanishing r ∧
  TermwiseVanishingOnRegularOrbits r ∧
  RegularOrbitAggregateVanishes r (regular_orbit_indices r) ∧
  OrbitwiseRegularVanishing r ∧
  RegularOrbitVanishing r := by
  have hRegInput : RegularChainInput r := regular_chain_input_from_separation r hSep
  have hOrbit : RegularOrbitVanishing r :=
    regular_orbit_vanishing_from_chain_input r hRegInput
  exact ⟨hRegInput.diffBridge, hRegInput.finiteSupport, hRegInput.analyticDependence,
    hRegInput.momentVanishing, hRegInput.termwiseVanishing, hRegInput.aggregateVanishing,
    hRegInput.orbitwiseVanishing, hOrbit⟩

end GCSF
