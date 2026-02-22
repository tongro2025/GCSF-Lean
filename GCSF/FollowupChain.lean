import GCSF.KudlaChain

namespace GCSF

/-- TeX: prop:central-parameterization from isolating and exact-kernel inputs. -/
theorem central_parameterization_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E) :
  CentralParameterization E r := by
  have _hIsoAtR : LambdaDeriv E r = A E r := hIso.isolatingPseudoCoefficient r
  have hKerAtR : LambdaDeriv E r = A E r := hKer.centerNormalization r
  exact ⟨hIso, hKer, hKerAtR⟩

/-- TeX: prop:kill-other-pi from the isolating-test input. -/
theorem kill_other_pi_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hIso : IsolatingTestExists E) :
  KillOtherPi E r := by
  have hIsoAtR : LambdaDeriv E r = A E r := hIso.isolatingPseudoCoefficient r
  exact ⟨hIso, hIsoAtR⟩

/-- TeX: prop:geom-independence from the geometric realization input. -/
theorem geometric_independence_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hGeom : GeometricRealization E r) :
  GeometricIndependence E r := by
  exact ⟨hGeom, hGeom.singularAsHeightRealization⟩

/-- TeX: prop:independence-family from geometric independence. -/
theorem independence_family_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hGeomInd : GeometricIndependence E r) :
  IndependenceFamily E r := by
  have _hGeom : GeometricRealization E r := hGeomInd.geometricInput
  exact ⟨hGeomInd, hGeomInd.geometricIndependenceIdentity⟩

/-- TeX: prop:spectral-interpretation from exact spectral extraction. -/
theorem spectral_interpretation_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hSpec : ExactSpectralExtraction E r) :
  SpectralInterpretation E r := by
  exact ⟨hSpec, hSpec.extractionIdentity⟩

/-- TeX: thm:selmer-rank from the Phase A conditional statement. -/
theorem selmer_rank_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hCond : GCSFConditional E r) :
  SelmerRankStatement E r := by
  exact ⟨hCond, hCond.conditionalIdentity⟩

/-- TeX: thm:regulator from the Phase A conditional statement. -/
theorem regulator_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hCond : GCSFConditional E r) :
  RegulatorStatement E r := by
  exact ⟨hCond, hCond.conditionalIdentity⟩

/-- TeX: thm:singular-as-height-CM from geometric realization. -/
theorem singular_as_height_cm_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hGeom : GeometricRealization E r) :
  SingularAsHeightCM E r := by
  exact ⟨hGeom, hGeom.singularAsHeightRealization⟩

/-- Extract the isolating-test witness from a conditional Phase A conclusion. -/
theorem isolating_test_from_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hCond : GCSFConditional E r) :
  IsolatingTestExists E := by
  exact (hCond.exactSpectral.centralDerivative.normalizedDerivative.kernelAdjusted).isolatedCoefficient.globalData.localData.isolatingWitness

/-- Extract the exact-kernel witness from a conditional Phase A conclusion. -/
theorem exact_kernel_from_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hCond : GCSFConditional E r) :
  ExactKernelNearCenter E := by
  exact hCond.exactSpectral.centralDerivative.normalizedDerivative.kernelAdjusted.kernelNearCenter

/-- Extract the geometric realization witness from a conditional Phase A conclusion. -/
theorem geometric_realization_from_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hCond : GCSFConditional E r) :
  GeometricRealization E r := by
  exact (hCond.spectralGeometric.centralAgreement.commonInvariant.certificate.matchData).geometricNorm.geometricPackage.geometricInput

/-- Extract the central-derivative package from a conditional Phase A conclusion. -/
theorem central_derivative_from_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hCond : GCSFConditional E r) :
  CentralDerivativePackage E r := by
  exact hCond.exactSpectral.centralDerivative

/-- Intermediate Phase-B data: isolating/kernel witnesses plus Kudla derivative identity. -/
theorem kudla_isolating_kernel_data
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  IsolatingTestExists E ∧
  ExactKernelNearCenter E ∧
  LambdaDeriv E r = A E r := by
  have hCond : GCSFConditional E r := phaseA_main_theorem_reduced E r
  exact ⟨isolating_test_from_conditional E r hCond,
    exact_kernel_from_conditional E r hCond,
    kudla_derivative_identity E r hKudla⟩

/-- Intermediate Phase-B data from conditional output: isolating/kernel + Kudla derivative identity. -/
theorem kudla_isolating_kernel_data_from_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r)
  (hCond : GCSFConditional E r) :
  IsolatingTestExists E ∧
  ExactKernelNearCenter E ∧
  LambdaDeriv E r = A E r := by
  exact ⟨isolating_test_from_conditional E r hCond,
    exact_kernel_from_conditional E r hCond,
    kudla_derivative_identity E r hKudla⟩

/-- Intermediate Phase-B data: geometric witness plus Kudla coefficient identity. -/
theorem kudla_geometric_data
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  GeometricRealization E r ∧ A E r = LambdaDeriv E r := by
  have hCond : GCSFConditional E r := phaseA_main_theorem_reduced E r
  exact ⟨geometric_realization_from_conditional E r hCond, kudla_arithmetic_identity E r hKudla⟩

/-- Intermediate Phase-B data from conditional output: geometric witness + Kudla coefficient identity. -/
theorem kudla_geometric_data_from_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r)
  (hCond : GCSFConditional E r) :
  GeometricRealization E r ∧ A E r = LambdaDeriv E r := by
  exact ⟨geometric_realization_from_conditional E r hCond, kudla_arithmetic_identity E r hKudla⟩

/-- Intermediate Phase-B data: central spectral package plus Kudla coefficient identity. -/
theorem kudla_exact_spectral_data
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  CentralDerivativePackage E r ∧ A E r = LambdaDeriv E r := by
  have hCond : GCSFConditional E r := phaseA_main_theorem_reduced E r
  exact ⟨central_derivative_from_conditional E r hCond, kudla_arithmetic_identity E r hKudla⟩

/-- Intermediate Phase-B data from conditional output: central package + Kudla coefficient identity. -/
theorem kudla_exact_spectral_data_from_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r)
  (hCond : GCSFConditional E r) :
  CentralDerivativePackage E r ∧ A E r = LambdaDeriv E r := by
  exact ⟨central_derivative_from_conditional E r hCond, kudla_arithmetic_identity E r hKudla⟩

/-- Phase-B intermediate lemma: central parameterization routed through Kudla-side input. -/
theorem central_parameterization_of_kudla
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  CentralParameterization E r := by
  rcases kudla_isolating_kernel_data E r hKudla with ⟨hIso, hKer, hDeriv⟩
  exact ⟨hIso, hKer, hDeriv⟩

/-- Phase-B intermediate lemma: kill-other-pi routed through Kudla-side input. -/
theorem kill_other_pi_of_kudla
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  KillOtherPi E r := by
  rcases kudla_isolating_kernel_data E r hKudla with ⟨hIso, _hKer, hDeriv⟩
  exact ⟨hIso, hDeriv⟩

/-- Phase-B intermediate lemma: geometric independence routed through Kudla-side input. -/
theorem geometric_independence_of_kudla
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  GeometricIndependence E r := by
  rcases kudla_geometric_data E r hKudla with ⟨hGeom, hCoeff⟩
  exact ⟨hGeom, hCoeff⟩

/-- Phase-B intermediate lemma: exact spectral extraction routed through Kudla-side input. -/
theorem exact_spectral_extraction_of_kudla
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  ExactSpectralExtraction E r := by
  rcases kudla_exact_spectral_data E r hKudla with ⟨hCentral, hCoeff⟩
  exact ⟨hCentral, hCoeff⟩

/-- Phase-B intermediate lemma: CM-height singular statement routed through Kudla-side input. -/
theorem singular_as_height_cm_of_kudla
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  SingularAsHeightCM E r := by
  rcases kudla_geometric_data E r hKudla with ⟨hGeom, hCoeff⟩
  exact ⟨hGeom, hCoeff⟩

/-- Aggregated follow-up snapshot over currently connected post-main labels. -/
theorem phaseB_followup_snapshot_from_kudla_and_conditional
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r)
  (hCond : GCSFConditional E r) :
  CentralParameterization E r ∧
  KillOtherPi E r ∧
  GeometricIndependence E r ∧
  IndependenceFamily E r ∧
  SpectralInterpretation E r ∧
  SelmerRankStatement E r ∧
  RegulatorStatement E r ∧
  SingularAsHeightCM E r := by
  have hIsoKer :
    IsolatingTestExists E ∧ ExactKernelNearCenter E ∧ LambdaDeriv E r = A E r :=
    kudla_isolating_kernel_data_from_conditional E r hKudla hCond
  rcases hIsoKer with ⟨hIso, hKer, hDeriv⟩
  have hCentral : CentralParameterization E r := ⟨hIso, hKer, hDeriv⟩
  have hKill : KillOtherPi E r := ⟨hIso, hDeriv⟩
  have hGeomData : GeometricRealization E r ∧ A E r = LambdaDeriv E r :=
    kudla_geometric_data_from_conditional E r hKudla hCond
  rcases hGeomData with ⟨hGeom, hCoeffGeom⟩
  have hGeomInd : GeometricIndependence E r := ⟨hGeom, hCoeffGeom⟩
  have hIndFam : IndependenceFamily E r := independence_family_theorem E r hGeomInd
  have hSpecData : CentralDerivativePackage E r ∧ A E r = LambdaDeriv E r :=
    kudla_exact_spectral_data_from_conditional E r hKudla hCond
  rcases hSpecData with ⟨hCentralPkg, hCoeffSpec⟩
  have hSpecExt : ExactSpectralExtraction E r := ⟨hCentralPkg, hCoeffSpec⟩
  have hSpecInterp : SpectralInterpretation E r := spectral_interpretation_theorem E r hSpecExt
  have hSelmer : SelmerRankStatement E r := selmer_rank_theorem E r hCond
  have hReg : RegulatorStatement E r := regulator_theorem E r hCond
  have hCM : SingularAsHeightCM E r := ⟨hGeom, hCoeffGeom⟩
  exact ⟨hCentral, hKill, hGeomInd, hIndFam, hSpecInterp, hSelmer, hReg, hCM⟩

/-- Aggregated follow-up snapshot over currently connected post-main labels. -/
theorem phaseB_followup_snapshot
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  CentralParameterization E r ∧
  KillOtherPi E r ∧
  GeometricIndependence E r ∧
  IndependenceFamily E r ∧
  SpectralInterpretation E r ∧
  SelmerRankStatement E r ∧
  RegulatorStatement E r ∧
  SingularAsHeightCM E r := by
  have hKudla : GeneralKudlaIdentity E r := kudla_assumption_from_input E r h
  have hCond : GCSFConditional E r := phaseB_conditional_from_input E r h
  exact phaseB_followup_snapshot_from_kudla_and_conditional E r hKudla hCond

/-- Explicit follow-up snapshot from Phase A + Kudla inputs. -/
theorem phaseB_followup_snapshot_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  CentralParameterization E r ∧
  KillOtherPi E r ∧
  GeometricIndependence E r ∧
  IndependenceFamily E r ∧
  SpectralInterpretation E r ∧
  SelmerRankStatement E r ∧
  RegulatorStatement E r ∧
  SingularAsHeightCM E r := by
  have hKudla' : GeneralKudlaIdentity E r := kudla_assumption_from_phaseA E r hPhaseA hKudla
  have hCond : GCSFConditional E r := kudla_conditional_from_phaseA E r hPhaseA hKudla
  exact phaseB_followup_snapshot_from_kudla_and_conditional E r hKudla' hCond

/-- Default follow-up snapshot from Phase A input. -/
theorem phaseB_followup_snapshot_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  CentralParameterization E r ∧
  KillOtherPi E r ∧
  GeometricIndependence E r ∧
  IndependenceFamily E r ∧
  SpectralInterpretation E r ∧
  SelmerRankStatement E r ∧
  RegulatorStatement E r ∧
  SingularAsHeightCM E r := by
  have hKudla : GeneralKudlaIdentity E r := kudla_assumption_from_phaseA_default E r hPhaseA
  have hCond : GCSFConditional E r := kudla_conditional_from_phaseA_default E r hPhaseA
  exact phaseB_followup_snapshot_from_kudla_and_conditional E r hKudla hCond

/-- Reduced-input follow-up snapshot over post-main labels. -/
theorem phaseB_followup_snapshot_reduced
  (E : EllipticCurve) (r : RankIndex) :
  CentralParameterization E r ∧
  KillOtherPi E r ∧
  GeometricIndependence E r ∧
  IndependenceFamily E r ∧
  SpectralInterpretation E r ∧
  SelmerRankStatement E r ∧
  RegulatorStatement E r ∧
  SingularAsHeightCM E r := by
  exact phaseB_followup_snapshot_from_phaseA_default E r {}

end GCSF
