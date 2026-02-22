import GCSF.CoreDefinitions

namespace GCSF

/-- Established-case interpretation node is definitionally the established input package. -/
theorem established_case_interpretation_from_input
  (E : EllipticCurve) (r : RankIndex)
  (hEst : EstablishedCaseInput E r) :
  GeometricInterpretationEstablished E r := by
  exact ⟨hEst, hEst.establishedCaseIdentity⟩

/-- Established interpretation is definitionally a geometric realization statement. -/
theorem established_to_general_realization_from_interpretation
  (E : EllipticCurve) (r : RankIndex)
  (hInterp : GeometricInterpretationEstablished E r) :
  GeometricRealization E r := by
  have hEst : EstablishedCaseInput E r := hInterp.establishedInput
  have _hInterpId : A E r = LambdaDeriv E r := hInterp.interpretationIdentity
  exact hEst.geometricInput

/-- TeX: thm:geometric-interpretation-established as a reusable chain theorem. -/
theorem geometric_realization_of_established_case
  (E : EllipticCurve)
  (r : RankIndex)
  (hEst : EstablishedCaseInput E r) :
  GeometricRealization E r := by
  have hInterp : GeometricInterpretationEstablished E r :=
    established_case_interpretation_from_input E r hEst
  exact established_to_general_realization_from_interpretation E r hInterp

end GCSF
