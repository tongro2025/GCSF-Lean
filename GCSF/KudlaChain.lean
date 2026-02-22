import GCSF.MainChain

namespace GCSF

/-- Reusable arithmetic/geometric coefficient identity extracted from Kudla input. -/
theorem kudla_arithmetic_identity
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  A E r = LambdaDeriv E r := by
  exact (phaseB_kudla_intermediate E r hKudla).left

/-- Reusable derivative-side identity extracted from Kudla input. -/
theorem kudla_derivative_identity
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  LambdaDeriv E r = A E r := by
  exact (phaseB_kudla_intermediate E r hKudla).right.left

/-- Reusable consistency identity extracted from Kudla input. -/
theorem kudla_consistency_identity
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  hKudla.derivativeCompatibility = hKudla.arithmeticGeometricCompatibility.symm := by
  exact (phaseB_kudla_intermediate E r hKudla).right.right

/-- Extract the Kudla-type assumption from the packaged Phase B input. -/
theorem kudla_assumption_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  GeneralKudlaIdentity E r := by
  exact h.kudlaInput

/-- Extract the Kudla-type assumption from explicit Phase A + Kudla inputs. -/
theorem kudla_assumption_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (_hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  GeneralKudlaIdentity E r := by
  exact hKudla

/-- Extract the default Kudla-type assumption from Phase A input. -/
theorem kudla_assumption_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  GeneralKudlaIdentity E r := by
  exact (phaseB_main_with_kudla_from_phaseA_default E r hPhaseA).left

/-- Intermediate Phase B bridge: Kudla assumption paired with regular-term annihilation. -/
theorem kudla_regular_bridge
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  GeneralKudlaIdentity E r ∧ RegularTermsAnnihilated r := by
  have hAll : RegularTermsAnnihilated r ∧ GeneralKudlaIdentity E r ∧ GCSFConditional E r :=
    phaseB_regular_then_main E r h
  rcases hAll with ⟨hReg, hKudla, _hMain⟩
  exact ⟨hKudla, hReg⟩

/-- Extract the regular-term annihilation component from packaged Phase B data. -/
theorem kudla_regular_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  RegularTermsAnnihilated r := by
  exact phaseB_regular_from_input E r h

/-- Extract regular-term annihilation from explicit Phase A + Kudla inputs. -/
theorem kudla_regular_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  RegularTermsAnnihilated r := by
  exact (phaseB_regular_then_main_from_phaseA E r hPhaseA hKudla).left

/-- Extract default regular-term annihilation from Phase A input. -/
theorem kudla_regular_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  RegularTermsAnnihilated r := by
  exact (phaseB_regular_then_main_from_phaseA_default E r hPhaseA).left

/-- Intermediate Phase B bridge: Kudla assumption paired with the conditional main conclusion. -/
theorem kudla_conditional_bridge
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  exact phaseB_main_with_kudla_from_input E r h

/-- Extract the conditional main component from packaged Phase B data. -/
theorem phaseB_conditional_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  GCSFConditional E r := by
  exact (kudla_conditional_bridge E r h).right

/-- Extract conditional main output from explicit Phase A + Kudla inputs. -/
theorem kudla_conditional_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  GCSFConditional E r := by
  exact (phaseB_main_with_kudla_from_phaseA E r hPhaseA hKudla).right

/-- Extract default conditional main output from Phase A input. -/
theorem kudla_conditional_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  GCSFConditional E r := by
  exact (phaseB_main_with_kudla_from_phaseA_default E r hPhaseA).right

/-- Structured Phase B snapshot over the Kudla-driven intermediate nodes. -/
theorem kudla_phaseB_snapshot
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  GeneralKudlaIdentity E r ∧
  RegularTermsAnnihilated r ∧
  GCSFConditional E r := by
  have hKudla : GeneralKudlaIdentity E r := kudla_assumption_from_input E r h
  have hReg : RegularTermsAnnihilated r := kudla_regular_from_input E r h
  have hMain : GCSFConditional E r := phaseB_conditional_from_input E r h
  exact ⟨hKudla, hReg, hMain⟩

/-- Explicit Phase-B Kudla snapshot from Phase A + Kudla inputs. -/
theorem kudla_phaseB_snapshot_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  GeneralKudlaIdentity E r ∧
  RegularTermsAnnihilated r ∧
  GCSFConditional E r := by
  have hKudla' : GeneralKudlaIdentity E r := kudla_assumption_from_phaseA E r hPhaseA hKudla
  have _hKudlaCons :
    hKudla'.derivativeCompatibility = hKudla'.arithmeticGeometricCompatibility.symm :=
    kudla_consistency_identity E r hKudla'
  have hReg : RegularTermsAnnihilated r := kudla_regular_from_phaseA E r hPhaseA hKudla
  have hMain : GCSFConditional E r := kudla_conditional_from_phaseA E r hPhaseA hKudla
  exact ⟨hKudla', hReg, hMain⟩

/-- Default Phase-B Kudla snapshot from Phase A input. -/
theorem kudla_phaseB_snapshot_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  GeneralKudlaIdentity E r ∧
  RegularTermsAnnihilated r ∧
  GCSFConditional E r := by
  have hKudla : GeneralKudlaIdentity E r := kudla_assumption_from_phaseA_default E r hPhaseA
  have hReg : RegularTermsAnnihilated r := kudla_regular_from_phaseA_default E r hPhaseA
  have hMain : GCSFConditional E r := kudla_conditional_from_phaseA_default E r hPhaseA
  exact ⟨hKudla, hReg, hMain⟩

/-- Reduced-input Phase B snapshot using theorem-backed packaged input. -/
theorem kudla_phaseB_snapshot_reduced
  (E : EllipticCurve) (r : RankIndex) :
  GeneralKudlaIdentity E r ∧
  RegularTermsAnnihilated r ∧
  GCSFConditional E r := by
  exact kudla_phaseB_snapshot_from_phaseA_default E r {}

end GCSF
