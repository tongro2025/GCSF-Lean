import GCSF.CoreDefinitions

namespace GCSF

/-- Spectral normalization is definitionally the spectral package itself. -/
theorem spectral_normalization_from_package
  (E : EllipticCurve) (r : RankIndex)
  (hSpecPkg : SpectralCentralPackage E r) :
  SpectralInvariantNormalization E r := by
  have _hWell : WellDefinedA E r := hSpecPkg.wellDefinedInput
  have hId : A E r = LambdaDeriv E r := hSpecPkg.spectralPackageIdentity
  exact ⟨hSpecPkg, hId⟩

/-- Geometric normalization is definitionally the geometric package itself. -/
theorem geometric_normalization_from_package
  (E : EllipticCurve) (r : RankIndex)
  (hGeomPkg : GeometricCentralPackage E r) :
  GeometricInvariantNormalization E r := by
  have _hGeom : GeometricRealization E r := hGeomPkg.geometricInput
  have hId : LambdaDeriv E r = A E r := hGeomPkg.geometricPackageIdentity
  exact ⟨hGeomPkg, hId⟩

/-- Normalization match data is definitionally a pair of normalized spectral/geometric forms. -/
theorem normalization_match_data
  (E : EllipticCurve) (r : RankIndex)
  (hSpecNorm : SpectralInvariantNormalization E r)
  (hGeomNorm : GeometricInvariantNormalization E r) :
  NormalizationMatchData E r := by
  have _hSpecPkg : SpectralCentralPackage E r := hSpecNorm.spectralPackage
  have _hGeomPkg : GeometricCentralPackage E r := hGeomNorm.geometricPackage
  have hSpecId : A E r = LambdaDeriv E r := hSpecNorm.spectralNormalizationIdentity
  have _hGeomId : LambdaDeriv E r = A E r := hGeomNorm.geometricNormalizationIdentity
  exact ⟨hSpecNorm, hGeomNorm, hSpecId⟩

/-- Certificate construction from normalization match data. -/
theorem common_invariant_certificate_of_match
  (E : EllipticCurve) (r : RankIndex)
  (hMatch : NormalizationMatchData E r) :
  CommonInvariantCertificate E r := by
  have _hSpecNorm : SpectralInvariantNormalization E r := hMatch.spectralNorm
  have hGeomNorm : GeometricInvariantNormalization E r := hMatch.geometricNorm
  have _hMatchId : A E r = LambdaDeriv E r := hMatch.normalizationIdentity
  exact ⟨hMatch, hGeomNorm.geometricNormalizationIdentity⟩

/-- Common invariant is definitionally the common-invariant certificate. -/
theorem common_invariant_from_certificate
  (E : EllipticCurve) (r : RankIndex)
  (hCert : CommonInvariantCertificate E r) :
  CommonCentralInvariant E r := by
  have _hMatch : NormalizationMatchData E r := hCert.matchData
  have hCertId : LambdaDeriv E r = A E r := hCert.certificateIdentity
  exact ⟨hCert, hCertId.symm⟩

/-- Full central agreement chain with explicit normalization steps. -/
theorem central_agreement_theorem
  (E : EllipticCurve)
  (r : RankIndex)
  (hSpecPkg : SpectralCentralPackage E r)
  (hGeomPkg : GeometricCentralPackage E r) :
  CentralSingularityAgreement E r := by
  have hSpecNorm : SpectralInvariantNormalization E r :=
    spectral_normalization_from_package E r hSpecPkg
  have hGeomNorm : GeometricInvariantNormalization E r :=
    geometric_normalization_from_package E r hGeomPkg
  have hMatch : NormalizationMatchData E r :=
    normalization_match_data E r hSpecNorm hGeomNorm
  have hCert : CommonInvariantCertificate E r :=
    common_invariant_certificate_of_match E r hMatch
  have hCommon : CommonCentralInvariant E r :=
    common_invariant_from_certificate E r hCert
  exact ⟨hCommon, hCommon.certificate.certificateIdentity⟩

/-- Structured witness for the normalization-based agreement chain. -/
theorem agreement_chain_snapshot
  (E : EllipticCurve)
  (r : RankIndex)
  (hSpecPkg : SpectralCentralPackage E r)
  (hGeomPkg : GeometricCentralPackage E r) :
  SpectralInvariantNormalization E r ∧
  GeometricInvariantNormalization E r ∧
  NormalizationMatchData E r ∧
  CommonInvariantCertificate E r ∧
  CommonCentralInvariant E r ∧
  CentralSingularityAgreement E r := by
  have hSpecNorm : SpectralInvariantNormalization E r :=
    spectral_normalization_from_package E r hSpecPkg
  have hGeomNorm : GeometricInvariantNormalization E r :=
    geometric_normalization_from_package E r hGeomPkg
  have hMatch : NormalizationMatchData E r :=
    normalization_match_data E r hSpecNorm hGeomNorm
  have hCert : CommonInvariantCertificate E r :=
    common_invariant_certificate_of_match E r hMatch
  have hCommon : CommonCentralInvariant E r :=
    common_invariant_from_certificate E r hCert
  have hAgree : CentralSingularityAgreement E r :=
    central_agreement_theorem E r hSpecPkg hGeomPkg
  exact ⟨hSpecNorm, hGeomNorm, hMatch, hCert, hCommon, hAgree⟩

end GCSF
