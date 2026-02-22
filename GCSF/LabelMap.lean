namespace GCSF

/-- TeX labels included in Phase A core chain. -/
def phaseACoreTexLabels : List String := [
  "ass:separation",
  "lem:diff-spectral",
  "lem:finite-orbits",
  "lem:analytic-oi",
  "prop:moment-vanishing",
  "prop:termwise-vanish",
  "prop:regular-vanishing",
  "thm:Dr-kills-regular",
  "thm:GCSF-well-defined",
  "ass:isolating-test",
  "ass:exact-kernel",
  "thm:exact-spectral-coefficient",
  "ass:geometric-interpretation-general",
  "thm:spec-geom-equality",
  "ass:bsd-decomposition",
  "thm:GCSF-conditional"
]

/-- Optional follow-up labels currently connected but not part of the final theorem shell. -/
def phaseBFollowupTexLabels : List String := [
  "ass:general-kudla-identity",
  "thm:geometric-interpretation-established",
  "prop:r0",
  "prop:r1-chain",
  "prop:central-parameterization",
  "prop:geom-independence",
  "prop:independence-family",
  "prop:kill-other-pi",
  "prop:spectral-interpretation",
  "thm:regulator",
  "thm:selmer-rank",
  "thm:singular-as-height-CM"
]

/-- Labels present in TeX but not yet wired to Lean declarations in this scaffold. -/
def phaseCBacklogTexLabels : List String := []

end GCSF
