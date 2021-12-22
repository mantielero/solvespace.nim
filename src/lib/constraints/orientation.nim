import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d
import general

# cSameOrientation
# -----------
proc sameOrientation*(n1, n2:Normal3d):Slvs_Constraint {.discardable.} = 
  ##[
    The normals entityA and entityB describe identical rotations. This
    constraint therefore restricts three degrees of freedom.

    Ignore the wrkpl member
  ]##
  var sys = n1.sys
  newConstraint( sys, cSameOrientation, 0.0,
                 0.IdEntity, 0.IdEntity, n1.id, n2.id, sys.currentWorkplane, sys.currentGroup )