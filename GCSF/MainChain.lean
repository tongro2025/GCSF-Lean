import GCSF.RegularChain
import GCSF.SpectralChain
import GCSF.EstablishedCaseChain
import GCSF.GeometricChain

namespace GCSF

/-- Aggregated Phase A input package for easier orchestration from TeX assumptions. -/
structure PhaseAInput (E : EllipticCurve) (r : RankIndex) : Type where
  separationInput : SeparationAssumption := separation_assumption_theorem
  wellDefinedInput : WellDefinedA E r := well_definedA_theorem E r
  isolatingInput : IsolatingTestExists E := isolating_test_exists_theorem E
  exactKernelInput : ExactKernelNearCenter E := exact_kernel_near_center_theorem E
  geometricInput : GeometricRealization E r := geometric_realization_theorem E r
  bsdInput : BSDDecomposition E r := bsd_decomposition_theorem E r
  regularChainInput : RegularChainInput r :=
    regular_chain_input_from_separation r separationInput
  regularChainConsistency :
    regularChainInput = regular_chain_input_from_separation r separationInput := by
      rfl

/-- Explicit constructor for packaged Phase A input data. -/
def phaseA_input
  (E : EllipticCurve) (r : RankIndex)
  (hSep : SeparationAssumption)
  (hWell : WellDefinedA E r)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E)
  (hGeom : GeometricRealization E r)
  (hBSD : BSDDecomposition E r) :
  PhaseAInput E r :=
  { separationInput := hSep
    wellDefinedInput := hWell
    isolatingInput := hIso
    exactKernelInput := hKer
    geometricInput := hGeom
    bsdInput := hBSD
    regularChainInput := regular_chain_input_from_separation r hSep
    regularChainConsistency := rfl }

/-- Default packaged Phase A input from theorem-backed witnesses. -/
def phaseA_input_default
  (E : EllipticCurve) (r : RankIndex) :
  PhaseAInput E r :=
  {}

/-- Reduced default Phase A input package. -/
def phaseA_input_reduced
  (E : EllipticCurve) (r : RankIndex) :
  PhaseAInput E r :=
  phaseA_input_default E r

/-- Phase B extension package: Phase A inputs plus the higher-rank Kudla-type assumption. -/
structure PhaseBInput (E : EllipticCurve) (r : RankIndex) : Type where
  phaseA : PhaseAInput E r
  kudlaInput : GeneralKudlaIdentity E r

/-- Snapshot bundle exposing packaged Phase B assumptions in a single Type-level payload. -/
structure PhaseBAssumptionSnapshot (E : EllipticCurve) (r : RankIndex) : Type where
  phaseA : PhaseAInput E r
  kudlaInput : GeneralKudlaIdentity E r
  regularInput : RegularChainInput r

/-- Explicit constructor for packaged Phase B input data. -/
def phaseB_input
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  PhaseBInput E r :=
  ⟨hPhaseA, hKudla⟩

/-- Build a Phase B input package from explicit Phase A + Kudla inputs. -/
def phaseB_input_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  PhaseBInput E r :=
  phaseB_input E r hPhaseA hKudla

/-- Build a Phase B input package from Phase A input using theorem-backed Kudla witness. -/
def phaseB_input_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  PhaseBInput E r :=
  phaseB_input_from_phaseA E r hPhaseA (general_kudla_identity_theorem E r)

/-- Reduced default Phase B input package. -/
def phaseB_input_reduced
  (E : EllipticCurve) (r : RankIndex) :
  PhaseBInput E r :=
  phaseB_input_from_phaseA_default E r (phaseA_input_default E r)

/-- Phase A MVP target: a typed main theorem shell with explicit assumptions. -/
theorem phaseA_main_theorem
  (E : EllipticCurve) (r : RankIndex)
  (hWell : WellDefinedA E r)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E)
  (hGeom : GeometricRealization E r)
  (hBSD : BSDDecomposition E r) :
  GCSFConditional E r := by
  have _hWellCoeff : A E r = LambdaDeriv E r := hWell.normalizedInvariantStability
  have _hWellDeriv : LambdaDeriv E r = A E r := hWell.centralDerivativeStability
  have _hWellCons :
      hWell.centralDerivativeStability = hWell.normalizedInvariantStability.symm :=
    hWell.wellDefinedConsistency
  have _hIso0 : LambdaDeriv E 0 = A E 0 :=
    hIso.isolatingPseudoCoefficient 0
  have _hIsoCons :
      ∀ (_π : Representation),
        hIso.localSpectralIsolation _π = hIso.isolatingPseudoCoefficient 0 :=
    hIso.centerIsolationConsistency
  have _hKer0 : LambdaDeriv E 0 = A E 0 := hKer.kernelModelNearCenter
  have _hKerCons : hKer.kernelModelNearCenter = hKer.centerNormalization 0 :=
    hKer.centerConsistency
  have _hGeomCoeff : A E r = LambdaDeriv E r := hGeom.singularAsHeightRealization
  have _hGeomCons :
      hGeom.geometricNormalization = hGeom.singularAsHeightRealization.symm :=
    hGeom.geometricConsistency
  have _hBSDCoeff : A E r = LambdaDeriv E r := hBSD.rankDecomposition
  have _hBSDDeriv : LambdaDeriv E r = A E r := hBSD.regulatorDecomposition
  have _hBSDCons :
      hBSD.regulatorDecomposition = hBSD.rankDecomposition.symm :=
    hBSD.decompositionConsistency
  have hSpecExt : ExactSpectralExtraction E r :=
    exact_spectral_extraction_theorem E r hIso hKer
  have hSpecGeom : SpectralGeometricEquality E r :=
    spec_geom_equality_theorem E r hWell hGeom
  exact ⟨hSpecExt, hSpecGeom, hBSD, hBSD.regulatorDecomposition⟩

/-- Packaged-input wrapper for the main conditional theorem. -/
theorem phaseA_main_theorem_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseAInput E r) :
  GCSFConditional E r := by
  exact phaseA_main_theorem E r h.wellDefinedInput
    h.isolatingInput h.exactKernelInput h.geometricInput h.bsdInput

/-- Reduced-input wrapper: only geometric/spectral side assumptions are required explicitly. -/
theorem phaseA_main_theorem_reduced
  (E : EllipticCurve) (r : RankIndex) :
  GCSFConditional E r := by
  exact phaseA_main_theorem_from_input E r (phaseA_input_reduced E r)

/-- Internal consistency bridge for packaged regular-chain input in `PhaseAInput`. -/
theorem phaseA_regular_chain_consistency
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseAInput E r) :
  h.regularChainInput = regular_chain_input_from_separation r h.separationInput := by
  exact h.regularChainConsistency

/-- Extract the regular-annihilation statement directly from packaged Phase A input. -/
theorem phaseA_regular_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseAInput E r) :
  RegularTermsAnnihilated r := by
  have _hRegCons :
      h.regularChainInput = regular_chain_input_from_separation r h.separationInput :=
    phaseA_regular_chain_consistency E r h
  exact regular_annihilation_from_chain_input r h.regularChainInput

/-- Snapshot of all top-level Phase A assumptions carried by the packaged input. -/
theorem phaseA_assumption_snapshot_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseAInput E r) :
  SeparationAssumption ∧
  WellDefinedA E r ∧
  IsolatingTestExists E ∧
  ExactKernelNearCenter E ∧
  GeometricRealization E r ∧
  BSDDecomposition E r ∧
  RegularChainInput r := by
  exact ⟨h.separationInput, h.wellDefinedInput, h.isolatingInput,
    h.exactKernelInput, h.geometricInput, h.bsdInput, h.regularChainInput⟩

/-- Reduced-input wrapper for the Phase A assumption snapshot. -/
theorem phaseA_assumption_snapshot_reduced
  (E : EllipticCurve) (r : RankIndex) :
  SeparationAssumption ∧
  WellDefinedA E r ∧
  IsolatingTestExists E ∧
  ExactKernelNearCenter E ∧
  GeometricRealization E r ∧
  BSDDecomposition E r ∧
  RegularChainInput r := by
  exact phaseA_assumption_snapshot_from_input E r (phaseA_input_reduced E r)

/-- Established-case route:
`thm:geometric-interpretation-established` feeds the same Phase A main theorem shell. -/
theorem phaseA_main_theorem_established_case
  (E : EllipticCurve) (r : RankIndex)
  (hWell : WellDefinedA E r)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E)
  (hEst : EstablishedCaseInput E r)
  (hBSD : BSDDecomposition E r) :
  GCSFConditional E r := by
  have hGeom : GeometricRealization E r :=
    geometric_realization_of_established_case E r hEst
  exact phaseA_main_theorem E r hWell hIso hKer hGeom hBSD

/-- Full Phase A pipeline from a single input package: regular annihilation and final conditional. -/
theorem phaseA_regular_then_main
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseAInput E r) :
  RegularTermsAnnihilated r ∧ GCSFConditional E r := by
  constructor
  · exact phaseA_regular_from_input E r h
  · exact phaseA_main_theorem_from_input E r h

/-- Reduced-input wrapper for the full Phase A regular+main pipeline. -/
theorem phaseA_regular_then_main_reduced
  (E : EllipticCurve) (r : RankIndex) :
  RegularTermsAnnihilated r ∧ GCSFConditional E r := by
  exact phaseA_regular_then_main E r (phaseA_input_reduced E r)

/-- Intermediate Phase-B payload extracted from `GeneralKudlaIdentity`. -/
theorem phaseB_kudla_intermediate
  (E : EllipticCurve) (r : RankIndex)
  (hKudla : GeneralKudlaIdentity E r) :
  (A E r = LambdaDeriv E r) ∧
  (LambdaDeriv E r = A E r) ∧
  hKudla.derivativeCompatibility = hKudla.arithmeticGeometricCompatibility.symm := by
  refine ⟨hKudla.arithmeticGeometricCompatibility, ?_⟩
  exact ⟨hKudla.derivativeCompatibility, hKudla.compatibilityConsistency⟩

/-- Phase B wrapper exposing `ass:general-kudla-identity` together with the Phase A main target. -/
theorem phaseB_main_with_kudla
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  have hKudlaData := phaseB_kudla_intermediate E r hKudla
  have _hKudlaCoeff : A E r = LambdaDeriv E r := hKudlaData.left
  have _hKudlaDeriv : LambdaDeriv E r = A E r := hKudlaData.right.left
  have _hKudlaCons :
    hKudla.derivativeCompatibility = hKudla.arithmeticGeometricCompatibility.symm :=
    hKudlaData.right.right
  exact ⟨hKudla, phaseA_main_theorem_from_input E r hPhaseA⟩

/-- Explicit Phase-B wrapper from Phase A + Kudla inputs via packaged constructor. -/
theorem phaseB_main_with_kudla_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  exact phaseB_main_with_kudla E r hPhaseA hKudla

/-- Default Phase-B wrapper from Phase A input using theorem-backed Kudla witness. -/
theorem phaseB_main_with_kudla_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  exact phaseB_main_with_kudla_from_phaseA E r hPhaseA (general_kudla_identity_theorem E r)

/-- Reduced-input Phase B wrapper using the theorem-backed Kudla witness. -/
theorem phaseB_main_with_kudla_reduced
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  exact phaseB_main_with_kudla_from_phaseA_default E r hPhaseA

/-- Input-package wrapper for the Phase B `GeneralKudlaIdentity` + conditional output. -/
theorem phaseB_main_with_kudla_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  exact phaseB_main_with_kudla_from_phaseA E r h.phaseA h.kudlaInput

/-- Extract regular-term annihilation from packaged Phase B input via the Phase A projection. -/
theorem phaseB_regular_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  RegularTermsAnnihilated r := by
  exact phaseA_regular_from_input E r h.phaseA

/-- Snapshot of top-level assumptions carried by packaged Phase B input. -/
def phaseB_assumption_snapshot_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  PhaseBAssumptionSnapshot E r := by
  exact ⟨h.phaseA, h.kudlaInput, h.phaseA.regularChainInput⟩

/-- Reduced-input wrapper for the packaged Phase B assumption snapshot. -/
def phaseB_assumption_snapshot_reduced
  (E : EllipticCurve) (r : RankIndex) :
  PhaseBAssumptionSnapshot E r := by
  exact phaseB_assumption_snapshot_from_input E r (phaseB_input_reduced E r)

/-- Snapshot of regular + conditional conclusions from packaged Phase B input. -/
theorem phaseB_result_snapshot_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  RegularTermsAnnihilated r ∧ GCSFConditional E r := by
  exact ⟨phaseB_regular_from_input E r h, phaseA_main_theorem_from_input E r h.phaseA⟩

/-- Reduced-input wrapper for packaged Phase B regular+conditional snapshot. -/
theorem phaseB_result_snapshot_reduced
  (E : EllipticCurve) (r : RankIndex) :
  RegularTermsAnnihilated r ∧ GCSFConditional E r := by
  exact phaseB_result_snapshot_from_input E r (phaseB_input_reduced E r)

/-- Phase B wrapper keeping regular annihilation explicit while carrying the Kudla assumption. -/
theorem phaseB_regular_then_main
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseBInput E r) :
  RegularTermsAnnihilated r ∧ GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  have hRegAnn : RegularTermsAnnihilated r := phaseB_regular_from_input E r h
  have hKudlaMain : GeneralKudlaIdentity E r ∧ GCSFConditional E r :=
    phaseB_main_with_kudla_from_input E r h
  rcases hKudlaMain with ⟨hKudla, hMain⟩
  exact ⟨hRegAnn, hKudla, hMain⟩

/-- Explicit Phase-B regular/main wrapper from Phase A + Kudla inputs. -/
theorem phaseB_regular_then_main_from_phaseA
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r)
  (hKudla : GeneralKudlaIdentity E r) :
  RegularTermsAnnihilated r ∧ GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  have hRegAnn : RegularTermsAnnihilated r := phaseA_regular_from_input E r hPhaseA
  have hMain : GCSFConditional E r := phaseA_main_theorem_from_input E r hPhaseA
  exact ⟨hRegAnn, hKudla, hMain⟩

/-- Default Phase-B regular/main wrapper from Phase A input using theorem-backed Kudla witness. -/
theorem phaseB_regular_then_main_from_phaseA_default
  (E : EllipticCurve) (r : RankIndex)
  (hPhaseA : PhaseAInput E r) :
  RegularTermsAnnihilated r ∧ GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  exact phaseB_regular_then_main_from_phaseA E r hPhaseA (general_kudla_identity_theorem E r)

/-- Reduced-input wrapper for regular-annihilation + Kudla + conditional output. -/
theorem phaseB_regular_then_main_reduced
  (E : EllipticCurve) (r : RankIndex) :
  RegularTermsAnnihilated r ∧ GeneralKudlaIdentity E r ∧ GCSFConditional E r := by
  exact phaseB_regular_then_main_from_phaseA_default E r (phaseA_input_reduced E r)

/-- Dependency snapshot to keep the regular/spectral core chain wired. -/
theorem phaseA_dependency_snapshot
  (E : EllipticCurve) (r : RankIndex)
  (hSep : SeparationAssumption)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E) :
  RegularTermsAnnihilated r ∧ ExactSpectralExtraction E r := by
  have _hSepCons :
      ∀ (_f : TestFamily) (E' : EllipticCurve) (r' : RankIndex),
        hSep.separatingTestFamily _f E' r' = (hSep.finiteRegularSupport E' r').symm :=
    hSep.separationConsistency
  have _hIsoCons :
      ∀ (_π : Representation),
        hIso.localSpectralIsolation _π = hIso.isolatingPseudoCoefficient 0 :=
    hIso.centerIsolationConsistency
  have _hKerCons : hKer.kernelModelNearCenter = hKer.centerNormalization 0 :=
    hKer.centerConsistency
  constructor
  · exact regular_annihilation_theorem r hSep
  · exact exact_spectral_extraction_theorem E r hIso hKer

/-- Packaged-input wrapper for dependency snapshot. -/
theorem phaseA_dependency_snapshot_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseAInput E r) :
  RegularTermsAnnihilated r ∧ ExactSpectralExtraction E r := by
  constructor
  · exact phaseA_regular_from_input E r h
  · exact exact_spectral_extraction_theorem E r h.isolatingInput h.exactKernelInput

/-- Reduced-input wrapper for dependency snapshot. -/
theorem phaseA_dependency_snapshot_reduced
  (E : EllipticCurve) (r : RankIndex) :
  RegularTermsAnnihilated r ∧ ExactSpectralExtraction E r := by
  exact phaseA_dependency_snapshot_from_input E r (phaseA_input_reduced E r)

/-- Expanded snapshot including regular, spectral, and spectral-geometric bridge nodes. -/
theorem phaseA_expanded_snapshot
  (E : EllipticCurve) (r : RankIndex)
  (hWell : WellDefinedA E r)
  (hSep : SeparationAssumption)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E)
  (hGeom : GeometricRealization E r) :
  DiffSpectralBridge r ∧
  FiniteRegularOrbitSupport r ∧
  AnalyticRegularOrbitDependence r ∧
  MomentVanishing r ∧
  TermwiseVanishingOnRegularOrbits r ∧
  RegularOrbitAggregateVanishes r (regular_orbit_indices r) ∧
  OrbitwiseRegularVanishing r ∧
  RegularOrbitVanishing r ∧
  LocalIsolatingData E r ∧
  GlobalIsolatingPackage E r ∧
  IsolatedSpectralCoefficient E r ∧
  KernelAdjustedSpectralPackage E r ∧
  SpectralDerivativeNormalization E r ∧
  CentralDerivativePackage E r ∧
  SpectralCentralPackage E r ∧
  GeometricCentralPackage E r ∧
  SpectralInvariantNormalization E r ∧
  GeometricInvariantNormalization E r ∧
  NormalizationMatchData E r ∧
  CommonInvariantCertificate E r ∧
  CommonCentralInvariant E r ∧
  CentralSingularityAgreement E r := by
  have hRegSnapshot := regular_chain_snapshot r hSep
  have hSpec := spectral_chain_snapshot E r hIso hKer
  have hGeomChain := geometric_chain_snapshot E r hWell hGeom
  rcases hRegSnapshot with
    ⟨hDiff, hFinite, hAnalytic, hMoment, hTermwise, hAgg, hOrbitwise, hOrbit⟩
  rcases hSpec with ⟨hLocal, hGlobal, hIsoCoeff, hKerAdj, hDerivNorm, hPkg⟩
  rcases hGeomChain with
    ⟨hSpecPkg, hGeomPkg, hSpecNorm, hGeomNorm, hMatch, hCert, hCommon, hAgree⟩
  exact ⟨hDiff, hFinite, hAnalytic, hMoment, hTermwise, hAgg, hOrbitwise, hOrbit,
    hLocal, hGlobal, hIsoCoeff, hKerAdj, hDerivNorm, hPkg,
    hSpecPkg, hGeomPkg, hSpecNorm, hGeomNorm, hMatch, hCert, hCommon, hAgree⟩

/-- Packaged-input wrapper for expanded snapshot. -/
theorem phaseA_expanded_snapshot_from_input
  (E : EllipticCurve) (r : RankIndex)
  (h : PhaseAInput E r) :
  DiffSpectralBridge r ∧
  FiniteRegularOrbitSupport r ∧
  AnalyticRegularOrbitDependence r ∧
  MomentVanishing r ∧
  TermwiseVanishingOnRegularOrbits r ∧
  RegularOrbitAggregateVanishes r (regular_orbit_indices r) ∧
  OrbitwiseRegularVanishing r ∧
  RegularOrbitVanishing r ∧
  LocalIsolatingData E r ∧
  GlobalIsolatingPackage E r ∧
  IsolatedSpectralCoefficient E r ∧
  KernelAdjustedSpectralPackage E r ∧
  SpectralDerivativeNormalization E r ∧
  CentralDerivativePackage E r ∧
  SpectralCentralPackage E r ∧
  GeometricCentralPackage E r ∧
  SpectralInvariantNormalization E r ∧
  GeometricInvariantNormalization E r ∧
  NormalizationMatchData E r ∧
  CommonInvariantCertificate E r ∧
  CommonCentralInvariant E r ∧
  CentralSingularityAgreement E r := by
  exact phaseA_expanded_snapshot E r h.wellDefinedInput h.separationInput
    h.isolatingInput h.exactKernelInput h.geometricInput

/-- Reduced-input wrapper for expanded snapshot. -/
theorem phaseA_expanded_snapshot_reduced
  (E : EllipticCurve) (r : RankIndex) :
  DiffSpectralBridge r ∧
  FiniteRegularOrbitSupport r ∧
  AnalyticRegularOrbitDependence r ∧
  MomentVanishing r ∧
  TermwiseVanishingOnRegularOrbits r ∧
  RegularOrbitAggregateVanishes r (regular_orbit_indices r) ∧
  OrbitwiseRegularVanishing r ∧
  RegularOrbitVanishing r ∧
  LocalIsolatingData E r ∧
  GlobalIsolatingPackage E r ∧
  IsolatedSpectralCoefficient E r ∧
  KernelAdjustedSpectralPackage E r ∧
  SpectralDerivativeNormalization E r ∧
  CentralDerivativePackage E r ∧
  SpectralCentralPackage E r ∧
  GeometricCentralPackage E r ∧
  SpectralInvariantNormalization E r ∧
  GeometricInvariantNormalization E r ∧
  NormalizationMatchData E r ∧
  CommonInvariantCertificate E r ∧
  CommonCentralInvariant E r ∧
  CentralSingularityAgreement E r := by
  exact phaseA_expanded_snapshot_from_input E r (phaseA_input_reduced E r)

end GCSF
