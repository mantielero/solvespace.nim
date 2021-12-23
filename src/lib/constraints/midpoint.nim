import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d
import general


# cAtMidpoint
# -----------------
proc midpoint*[P:Point3d | Point2d](point:P; line:Segment):Slvs_Constraint {.discardable.} =
  ##[
    The point ptA lies at the midpoint of the line entityA.

    May be used in 3d or projected into a workplane
  ]##
  var sys = point.sys
  newConstraint( sys, cAtMidpoint, 0.0,
                 point.id, 0.IdEntity, line.id, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )