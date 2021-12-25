import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d
import general

# cSymmetric
# -----------------
proc symmetric*[P1,P2:Point3d | Point2d](p1:P1; p2:P2; 
          workplane:Workplane):Slvs_Constraint {.discardable.} =
  ##[
  The points ptA and ptB are symmetric about the plane entityA. This
    means that they are on opposite sides of the plane and at equal
    distances from the plane, and that the line connecting ptA and ptB
    is normal to the plane.

  Must always be used with a workplane
  ]##
  var sys = p1.sys
  newConstraint( sys, cSymmetric, 0.0,
                 p1.id, p2.id, workplane.id, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )

# cSymmetricHoriz
proc symmetricHorizontal*(p1, p2: Point2d):Slvs_Constraint {.discardable.} =
  ##[
  The points ptA and ptB are symmetric about the horizontal
    axis of the specified workplane.

  Must always be used with a workplane
  ]##
  var sys = p1.sys
  newConstraint( sys, cSymmetricHoriz, 0.0,
                 p1.id, p2.id, 0.IdEntity, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )

# cSymmetricVert
proc symmetricVertical*(p1,p2:Point2d):Slvs_Constraint {.discardable.} =
  ##[
  The points ptA and ptB are symmetric about the vertical
    axis of the specified workplane.

  Must always be used with a workplane
  ]##
  var sys = p1.sys
  newConstraint( sys, cSymmetricVert, 0.0,
                 p1.id, p2.id, 0.IdEntity, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )

# cSymmetricLine
proc symmetricLine*(p1, p2:Point2d; line:Segment):Slvs_Constraint {.discardable.} =
  ##[
  The points ptA and ptB are symmetric about the line entityA.

  Must always be used with a workplane
  ]##
  var sys = p1.sys
  newConstraint( sys, cSymmetricLine, 0.0,
                 p1.id, p2.id, line.id, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )