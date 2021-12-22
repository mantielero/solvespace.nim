import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d
import general

# cPtOnCircle
# -----------
proc on*[P:Point3d | Point2d](point:P; circle:Circle | ArcOfCircle):Slvs_Constraint {.discardable.} = 
  ##[
    The point ptA lies on the right cylinder obtained by extruding circle
    or arc entityA normal to its plane.

    Ignore the wrkpl member
  ]##
  var sys = point.sys
  newConstraint( sys, cPtOnCircle, 0.0,
                 point.id, 0.IdEntity, circle.id, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )