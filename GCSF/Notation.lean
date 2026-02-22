namespace GCSF

/-- Abstract base type for elliptic curves over Q (model-level placeholder). -/
opaque EllipticCurve : Type

/-- Abstract type for admissible test-function families in the relative trace formula. -/
opaque TestFamily : Type

/-- Abstract type for automorphic representations involved in the spectral side. -/
opaque Representation : Type

/-- Abstract scalar codomain for central coefficients and pairings. -/
def Scalar := Unit

/-- `opaque` declarations require an inhabited codomain in this scaffold. -/
instance : Inhabited Scalar := ⟨()⟩

/-- r in central derivatives and singular coefficients. -/
def RankIndex := Nat

instance : Inhabited RankIndex := ⟨Nat.zero⟩
instance (n : Nat) : OfNat RankIndex n := ⟨n⟩

/-- Normalized central singularity coefficient A_r(E). -/
opaque A : EllipticCurve → RankIndex → Scalar

/-- r-th derivative of the completed L-function at the center (abstracted). -/
opaque LambdaDeriv : EllipticCurve → RankIndex → Scalar

/-- Any two scaffold scalars are propositionally equal since `Scalar` is `Unit`. -/
theorem scalar_eq (x y : Scalar) : x = y := by
  cases x
  cases y
  rfl

end GCSF
