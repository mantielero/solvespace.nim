import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d
import general


# cCoincidentPoints: coincident points
# ------------------------------------
proc coincident*[P1,P2:Point3d | Point2d](p1:P1; p2:P2;  
          workplane:Workplane; group:IdGroup):Slvs_Constraint {.discardable.} = 
  ##[
    Points ptA and ptB are coincident (i.e., exactly on top of each
    other).

    May be used in 3d or projected into a workplane.
  ]##
  var sys = p1.sys
  newConstraint( sys, cCoincidentPoints, 0.0,
                 p1.id, p2.id, 0.IdEntity, 0.IdEntity, workplane, group )


proc coincident*[P1,P2:Point3d | Point2d](p1:P1; p2:P2):Slvs_Constraint {.discardable.} = 
  ##[
    Points ptA and ptB are coincident (i.e., exactly on top of each
    other).

    May be used in 3d or projected into a workplane.
  ]##
  coincident( p1, p2, p1.sys.currentWorkplane, p1.sys.currentGroup )


# cPtInPlane
# ----------
proc coincident*[P:Point3d | Point2d](p:P; wrkpl:Workplane):Slvs_Constraint {.discardable.} = 
  ##[
    The point ptA lies in plane entityA.

    Ignore the current Workplane member
  ]##
  var sys = p.sys
  newConstraint( sys, cPtInPlane, 0.0,
                 p.id, 0.IdEntity, wrkpl.id, 0.IdEntity, p.sys.currentWorkplane, p.sys.currentGroup )


# cPtOnLine
proc coincident*[P:Point3d | Point2d](p:P; line:Segment):Slvs_Constraint {.discardable.} = 
  ##[
    The point ptA lies on the line entityA.

    Note that this constraint removes one degree of freedom when projected
    in to the plane, but two degrees of freedom in 3d.

    May be used in 3d or projected into a workplane 
  ]##
  var sys = p.sys
  newConstraint( sys, cPtOnLine, 0.0,
                 p.id, 0.IdEntity, line.id, 0.IdEntity, p.sys.currentWorkplane, p.sys.currentGroup )

