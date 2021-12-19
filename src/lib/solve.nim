import ../wrapper/slvs
import types, constants

proc solve*( s:var System; group:uint ):Result =
  s.sys.params      = s.params.len.cint
  s.sys.entities    = s.entities.len.cint
  s.sys.constraints = s.constraints.len.cint
  s.sys.param       = cast[ptr UncheckedArray[Slvs_Param]](s.params[0].unsafeAddr)
  s.sys.entity      = cast[ptr UncheckedArray[Slvs_Entity]](s.entities[0].unsafeAddr)
  s.sys.constraint  = cast[ptr UncheckedArray[Slvs_Constraint]](s.constraints[0].unsafeAddr)  

  Slvs_Solve(cast[ptr Slvs_System](s.sys.unsafeAddr), group.Slvs_hGroup )  # Slvs_Solve(sys.unsafeAddr, g)

  result = case s.sys.result:
            of SLVS_RESULT_OKAY:              rOK
            of SLVS_RESULT_INCONSISTENT:      rInconsistent
            of SLVS_RESULT_DIDNT_CONVERGE:    rConverge
            of SLVS_RESULT_TOO_MANY_UNKNOWNS: rTooManyUnknowns
            else:
              raise newException(ValueError, "the solver is returning an unknown value")


