import GCSF.CoreDefinitions

namespace GCSF

/-- Local isolating data is assembled from the isolating-test witness at rank `r`. -/
theorem local_isolation_data_from_exists
  (E : EllipticCurve) (r : RankIndex)
  (hIso : IsolatingTestExists E) :
  LocalIsolatingData E r := by
  have hIsoAtR : LambdaDeriv E r = A E r := hIso.isolatingPseudoCoefficient r
  have _hIsoCons :
      ∀ (_π : Representation),
        hIso.localSpectralIsolation _π = hIso.isolatingPseudoCoefficient 0 :=
    hIso.centerIsolationConsistency
  exact ⟨hIso, hIsoAtR⟩

/-- Global isolating package is assembled from local isolating data. -/
theorem global_isolation_from_local
  (E : EllipticCurve) (r : RankIndex)
  (hLocal : LocalIsolatingData E r) :
  GlobalIsolatingPackage E r := by
  have hLocalEq : LambdaDeriv E r = A E r := hLocal.localCoefficientAgreement
  exact ⟨hLocal, hLocalEq.symm⟩

/-- Isolated spectral coefficient is assembled from the global package. -/
theorem isolated_coefficient_from_global
  (E : EllipticCurve) (r : RankIndex)
  (hGlobal : GlobalIsolatingPackage E r) :
  IsolatedSpectralCoefficient E r := by
  have hGlobalEq : A E r = LambdaDeriv E r := hGlobal.globalizationIdentity
  exact ⟨hGlobal, hGlobalEq.symm⟩

/-- Kernel-adjusted package combines exact-kernel and isolated-coefficient data. -/
theorem kernel_adjustment_from_kernel_and_isolated
  (E : EllipticCurve) (r : RankIndex)
  (hKer : ExactKernelNearCenter E)
  (hIsoCoeff : IsolatedSpectralCoefficient E r) :
  KernelAdjustedSpectralPackage E r := by
  have _hKerCenter : LambdaDeriv E 0 = A E 0 := hKer.kernelModelNearCenter
  have _hKerCons :
      hKer.kernelModelNearCenter = hKer.centerNormalization 0 :=
    hKer.centerConsistency
  have _hIsoCoeffEq : LambdaDeriv E r = A E r := hIsoCoeff.isolatedCoefficientIdentity
  exact ⟨hKer, hIsoCoeff⟩

/-- Derivative normalization is assembled from kernel-adjusted spectral data. -/
theorem derivative_normalization_from_kernel_adjusted
  (E : EllipticCurve) (r : RankIndex)
  (hKerAdj : KernelAdjustedSpectralPackage E r) :
  SpectralDerivativeNormalization E r := by
  have _hKernelAll : ∀ r' : RankIndex, LambdaDeriv E r' = A E r' :=
    hKerAdj.kernelNearCenter.centerNormalization
  have hIsoCoeffEq : LambdaDeriv E r = A E r :=
    hKerAdj.isolatedCoefficient.isolatedCoefficientIdentity
  exact ⟨hKerAdj, hIsoCoeffEq⟩

/-- Central derivative package is assembled from normalized derivative data. -/
theorem central_derivative_package_from_normalization
  (E : EllipticCurve) (r : RankIndex)
  (hNorm : SpectralDerivativeNormalization E r) :
  CentralDerivativePackage E r := by
  have hNormEq : LambdaDeriv E r = A E r := hNorm.derivativeNormalizationIdentity
  exact ⟨hNorm, hNormEq.symm⟩

/-- Exact spectral extraction is assembled from the central derivative package. -/
theorem exact_extraction_from_package
  (E : EllipticCurve) (r : RankIndex)
  (hPkg : CentralDerivativePackage E r) :
  ExactSpectralExtraction E r := by
  have hCentralId : A E r = LambdaDeriv E r := hPkg.centralDerivativeIdentity
  exact ⟨hPkg, hCentralId⟩

/-- TeX: thm:exact-spectral-coefficient via explicit intermediate interfaces. -/
theorem exact_spectral_extraction_theorem
  (E : EllipticCurve)
  (r : RankIndex)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E) :
  ExactSpectralExtraction E r := by
  have _hIso0 : LambdaDeriv E 0 = A E 0 :=
    hIso.isolatingPseudoCoefficient 0
  have _hIsoRep : ∀ (_π : Representation), LambdaDeriv E 0 = A E 0 :=
    hIso.localSpectralIsolation
  have _hIsoCons :
      ∀ (_π : Representation),
        hIso.localSpectralIsolation _π = hIso.isolatingPseudoCoefficient 0 :=
    hIso.centerIsolationConsistency
  have _hKer0 : LambdaDeriv E 0 = A E 0 := hKer.kernelModelNearCenter
  have _hKerAll : ∀ r' : RankIndex, LambdaDeriv E r' = A E r' :=
    hKer.centerNormalization
  have _hKerCons : hKer.kernelModelNearCenter = hKer.centerNormalization 0 :=
    hKer.centerConsistency
  have hLocal : LocalIsolatingData E r := local_isolation_data_from_exists E r hIso
  have hGlobal : GlobalIsolatingPackage E r := global_isolation_from_local E r hLocal
  have hIsoCoeff : IsolatedSpectralCoefficient E r :=
    isolated_coefficient_from_global E r hGlobal
  have hKerAdj : KernelAdjustedSpectralPackage E r :=
    kernel_adjustment_from_kernel_and_isolated E r hKer hIsoCoeff
  have hNorm : SpectralDerivativeNormalization E r :=
    derivative_normalization_from_kernel_adjusted E r hKerAdj
  have hPkg : CentralDerivativePackage E r :=
    central_derivative_package_from_normalization E r hNorm
  exact exact_extraction_from_package E r hPkg

/-- Structured witness for the spectral extraction bridge. -/
theorem spectral_chain_snapshot
  (E : EllipticCurve)
  (r : RankIndex)
  (hIso : IsolatingTestExists E)
  (hKer : ExactKernelNearCenter E) :
  LocalIsolatingData E r ∧
  GlobalIsolatingPackage E r ∧
  IsolatedSpectralCoefficient E r ∧
  KernelAdjustedSpectralPackage E r ∧
  SpectralDerivativeNormalization E r ∧
  CentralDerivativePackage E r := by
  have hLocal : LocalIsolatingData E r := local_isolation_data_from_exists E r hIso
  have hGlobal : GlobalIsolatingPackage E r := global_isolation_from_local E r hLocal
  have hIsoCoeff : IsolatedSpectralCoefficient E r :=
    isolated_coefficient_from_global E r hGlobal
  have hKerAdj : KernelAdjustedSpectralPackage E r :=
    kernel_adjustment_from_kernel_and_isolated E r hKer hIsoCoeff
  have hNorm : SpectralDerivativeNormalization E r :=
    derivative_normalization_from_kernel_adjusted E r hKerAdj
  have hPkg : CentralDerivativePackage E r :=
    central_derivative_package_from_normalization E r hNorm
  exact ⟨hLocal, hGlobal, hIsoCoeff, hKerAdj, hNorm, hPkg⟩

end GCSF
