import GCSF.AgreementChain

namespace GCSF

/-- TeX: thm:spec-geom-equality via explicit intermediate compatibility nodes. -/
theorem spec_geom_equality_theorem
  (E : EllipticCurve)
  (r : RankIndex)
  (hWell : WellDefinedA E r)
  (hGeom : GeometricRealization E r) :
  SpectralGeometricEquality E r := by
  have _hWellCoeff : A E r = LambdaDeriv E r := hWell.normalizedInvariantStability
  have _hWellDeriv : LambdaDeriv E r = A E r := hWell.centralDerivativeStability
  have _hWellCons :
      hWell.centralDerivativeStability = hWell.normalizedInvariantStability.symm :=
    hWell.wellDefinedConsistency
  have _hGeomCoeff : A E r = LambdaDeriv E r := hGeom.singularAsHeightRealization
  have _hGeomDeriv : LambdaDeriv E r = A E r := hGeom.geometricNormalization
  have _hGeomCons :
      hGeom.geometricNormalization = hGeom.singularAsHeightRealization.symm :=
    hGeom.geometricConsistency
  have hSpecPkg : SpectralCentralPackage E r :=
    ⟨hWell, hWell.normalizedInvariantStability⟩
  have hGeomPkg : GeometricCentralPackage E r :=
    ⟨hGeom, hGeom.geometricNormalization⟩
  have hAgree : CentralSingularityAgreement E r :=
    central_agreement_theorem E r hSpecPkg hGeomPkg
  exact ⟨hAgree, hAgree.agreementIdentity.symm⟩

/-- Structured witness that the spectral-geometric chain is fully wired. -/
theorem geometric_chain_snapshot
  (E : EllipticCurve)
  (r : RankIndex)
  (hWell : WellDefinedA E r)
  (hGeom : GeometricRealization E r) :
  SpectralCentralPackage E r ∧
  GeometricCentralPackage E r ∧
  SpectralInvariantNormalization E r ∧
  GeometricInvariantNormalization E r ∧
  NormalizationMatchData E r ∧
  CommonInvariantCertificate E r ∧
  CommonCentralInvariant E r ∧
  CentralSingularityAgreement E r := by
  have _hWellCons :
      hWell.centralDerivativeStability = hWell.normalizedInvariantStability.symm :=
    hWell.wellDefinedConsistency
  have _hGeomCons :
      hGeom.geometricNormalization = hGeom.singularAsHeightRealization.symm :=
    hGeom.geometricConsistency
  have hSpecPkg : SpectralCentralPackage E r :=
    ⟨hWell, hWell.normalizedInvariantStability⟩
  have hGeomPkg : GeometricCentralPackage E r :=
    ⟨hGeom, hGeom.geometricNormalization⟩
  have hAgreement :=
    agreement_chain_snapshot E r hSpecPkg hGeomPkg
  rcases hAgreement with ⟨hSpecNorm, hGeomNorm, hMatch, hCert, hCommon, hAgree⟩
  exact ⟨hSpecPkg, hGeomPkg, hSpecNorm, hGeomNorm, hMatch, hCert, hCommon, hAgree⟩

end GCSF
