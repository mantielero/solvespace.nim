import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d
import general

# cWhereDragged
# ------
proc dragged*(point:Point3d | Point2d):Slvs_Constraint {.discardable.} = 
  ##[
    The point ptA is locked at its initial numerical guess, and cannot
    be moved. This constrains two degrees of freedom in a workplane,
    and three in free space. It's therefore possible for this constraint
    to overconstrain the sketch, for example if it's applied to a point
    with one remaining degree of freedom.

  May be used in 3d or projected into a workplane.
  ]##
  var sys = point.sys
  newConstraint( sys, cWhereDragged, 0.0,
                 point.id, 0.IdEntity, 0.IdEntity, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )



