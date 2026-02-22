import GCSF.MainChain

namespace GCSF

/-- TeX: prop:r0.
Low-rank anchor at `r = 0`, keeping Kudla input and Phase A conditional output bundled. -/
theorem low_rank_prop_r0
  (E : EllipticCurve)
  (h0 : PhaseBInput E 0) :
  GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0 := by
  exact phaseB_main_with_kudla_from_input E 0 h0

/-- TeX: prop:r1-chain.
Phase-B packaged statements at `r = 0` and `r = 1` are tracked together. -/
theorem low_rank_prop_r1_chain
  (E : EllipticCurve)
  (h0 : PhaseBInput E 0)
  (h1 : PhaseBInput E 1) :
  (GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact ⟨phaseB_main_with_kudla_from_input E 0 h0, phaseB_main_with_kudla_from_input E 1 h1⟩

/-- Structured low-rank snapshot exposing regular-annihilation outputs at both base ranks. -/
theorem low_rank_snapshot
  (E : EllipticCurve)
  (h0 : PhaseBInput E 0)
  (h1 : PhaseBInput E 1) :
  (RegularTermsAnnihilated 0 ∧ GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (RegularTermsAnnihilated 1 ∧ GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact ⟨phaseB_regular_then_main E 0 h0, phaseB_regular_then_main E 1 h1⟩

/-- Explicit low-rank anchor from Phase A + Kudla inputs at `r = 0`. -/
theorem low_rank_prop_r0_from_phaseA
  (E : EllipticCurve)
  (hPhaseA0 : PhaseAInput E 0)
  (hKudla0 : GeneralKudlaIdentity E 0) :
  GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0 := by
  exact phaseB_main_with_kudla_from_phaseA E 0 hPhaseA0 hKudla0

/-- Explicit low-rank chain from Phase A + Kudla inputs at `r = 0` and `r = 1`. -/
theorem low_rank_prop_r1_chain_from_phaseA
  (E : EllipticCurve)
  (hPhaseA0 : PhaseAInput E 0)
  (hKudla0 : GeneralKudlaIdentity E 0)
  (hPhaseA1 : PhaseAInput E 1)
  (hKudla1 : GeneralKudlaIdentity E 1) :
  (GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact ⟨phaseB_main_with_kudla_from_phaseA E 0 hPhaseA0 hKudla0,
    phaseB_main_with_kudla_from_phaseA E 1 hPhaseA1 hKudla1⟩

/-- Explicit low-rank snapshot from Phase A + Kudla inputs at base ranks. -/
theorem low_rank_snapshot_from_phaseA
  (E : EllipticCurve)
  (hPhaseA0 : PhaseAInput E 0)
  (hKudla0 : GeneralKudlaIdentity E 0)
  (hPhaseA1 : PhaseAInput E 1)
  (hKudla1 : GeneralKudlaIdentity E 1) :
  (RegularTermsAnnihilated 0 ∧ GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (RegularTermsAnnihilated 1 ∧ GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact ⟨phaseB_regular_then_main_from_phaseA E 0 hPhaseA0 hKudla0,
    phaseB_regular_then_main_from_phaseA E 1 hPhaseA1 hKudla1⟩

/-- Default low-rank anchor from Phase A input at `r = 0`. -/
theorem low_rank_prop_r0_from_phaseA_default
  (E : EllipticCurve)
  (hPhaseA0 : PhaseAInput E 0) :
  GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0 := by
  exact phaseB_main_with_kudla_from_phaseA_default E 0 hPhaseA0

/-- Default low-rank chain from Phase A inputs at `r = 0` and `r = 1`. -/
theorem low_rank_prop_r1_chain_from_phaseA_default
  (E : EllipticCurve)
  (hPhaseA0 : PhaseAInput E 0)
  (hPhaseA1 : PhaseAInput E 1) :
  (GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact ⟨phaseB_main_with_kudla_from_phaseA_default E 0 hPhaseA0,
    phaseB_main_with_kudla_from_phaseA_default E 1 hPhaseA1⟩

/-- Default low-rank snapshot from Phase A inputs at base ranks. -/
theorem low_rank_snapshot_from_phaseA_default
  (E : EllipticCurve)
  (hPhaseA0 : PhaseAInput E 0)
  (hPhaseA1 : PhaseAInput E 1) :
  (RegularTermsAnnihilated 0 ∧ GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (RegularTermsAnnihilated 1 ∧ GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact ⟨phaseB_regular_then_main_from_phaseA_default E 0 hPhaseA0,
    phaseB_regular_then_main_from_phaseA_default E 1 hPhaseA1⟩

/-- Reduced-input low-rank anchor at `r = 0`. -/
theorem low_rank_prop_r0_reduced
  (E : EllipticCurve) :
  GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0 := by
  exact low_rank_prop_r0_from_phaseA_default E {}

/-- Reduced-input low-rank chain at `r = 0` and `r = 1`. -/
theorem low_rank_prop_r1_chain_reduced
  (E : EllipticCurve) :
  (GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact low_rank_prop_r1_chain_from_phaseA_default E {} {}

/-- Reduced-input structured low-rank snapshot over base ranks. -/
theorem low_rank_snapshot_reduced
  (E : EllipticCurve) :
  (RegularTermsAnnihilated 0 ∧ GeneralKudlaIdentity E 0 ∧ GCSFConditional E 0) ∧
  (RegularTermsAnnihilated 1 ∧ GeneralKudlaIdentity E 1 ∧ GCSFConditional E 1) := by
  exact low_rank_snapshot_from_phaseA_default E {} {}

end GCSF
