import ../../wrapper/slvs
import ../types, ../constants,
import general


# cEqualAngle
# -----------------
proc equalAngle*(line1, line2, line3, line4:Segment):Slvs_Constraint {.discardable.} = 
  ##[
  The angle between lines entityA and entityB is equal to the angle
    between lines entityC and entityD.

    If other is true, then the angles are supplementary (i.e., theta1 =
    180 - theta2) instead of equal.

  May be used in 3d or projected into a workplane
  ]##
  var sys = point.sys
  newConstraint( sys, cEqualAngle, 0.0,
                 line1.id, line2.id, line3.id, line4.id, sys.currentWorkplane, sys.currentGroup )

# cAngle
# ------
proc angle*[N:SomeNumber](line1, line2:Segment; val:N):Slvs_Constraint {.discardable.} = 
  ##[
    The angle between lines entityA and entityB is equal to valA, where
    valA is specified in degrees. This constraint equation is written
    in the form

        (A dot B)/(|A||B|) = cos(valA)

    where A and B are vectors in the directions of lines A and B. This
    equation does not specify the angle unambiguously; for example,
    note that valA = +/- 90 degrees will produce the same equation.

    If other is true, then the constraint is instead that

        (A dot B)/(|A||B|) = -cos(valA)

  May be used in 3d or projected into a workplane
  ]##
  var sys = point.sys
  newConstraint( sys, cAngle, val,
                 0.IdEntity, 0.IdEntity, line1.id, line2.id, sys.currentWorkplane, sys.currentGroup )


# cParallel
# ---------
proc parallel*(line1, line2:Segment):Slvs_Constraint {.discardable.} = 
  ##[
    Lines entityA and entityB are parallel.

    Note that this constraint removes one degree of freedom when projected
    in to the plane, but two degrees of freedom in 3d.

  May be used in 3d or projected into a workplane
  ]##
  var sys = point.sys
  newConstraint( sys, cParallel, 0.0,
                 0.IdEntity, 0.IdEntity, line1.id, line2.id, sys.currentWorkplane, sys.currentGroup )


# cPerpendicular
proc perpendicular*(line1, line2:Segment):Slvs_Constraint {.discardable.} = 
  ##[
    Identical to SLVS_C_ANGLE with valA = 90 degrees.

  May be used in 3d or projected into a workplane
  ]##
  var sys = point.sys
  newConstraint( sys, cPerpendicular, 0.0,
                 0.IdEntity, 0.IdEntity, line1.id, line2.id, sys.currentWorkplane, sys.currentGroup )