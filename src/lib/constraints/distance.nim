import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d, ../segment
import general

# cDistancePtPt: distance between points
# ----------------------------------------------
proc distance*[N:SomeNumber; P1,P2:Point3d | Point2d](p1:P1; p2:P2; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint {.discardable.} =
  ##[
    Distance between points ptA and ptB is equal to valA. This is an
    unsigned distance, so valA must always be positive.
    May be used in 3d or projected into a workplane.
  ]##
  var sys = p1.sys
  newConstraint( sys, cDistancePtPt, distance,
                 p1.id, p2.id, 0.IdEntity, 0.IdEntity, workplane, group )

proc distance*[N:SomeNumber; P1,P2:Point3d | Point2d](p1:P1; p2:P2; distance:N):Slvs_Constraint {.discardable.} =
  ##[
    Distance between points ptA and ptB is equal to valA. This is an
    unsigned distance, so valA must always be positive.
    May be used in 3d or projected into a workplane.
  ]##
  distance(p1, p2, distance, p1.sys.currentWorkplane, p1.sys.currentGroup)

proc length*[N:SomeNumber](s:Segment; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint {.discardable.} = 
  ##[
    sets the length of a segment. This is an
    unsigned distance, so valA must always be positive.
    May be used in 3d or projected into a workplane.
  ]##          
  let points = s.getPoints 
  if points[0].typ == SLVS_E_POINT_IN_3D:
    #[     let p1 = points[0].id.Point3d
    let p2 = points[1].id.Point3d ]#
    var p1:Point3d
    p1.id = points[0].id
    p1.sys = s.sys
    var p2:Point3d
    p2.id = points[1].id
    p2.sys = s.sys    

    distance(p1,p2, distance, workplane, group)
  else:
    let p1 = toPoint2d(s.sys, points[0].id)
    let p2 = toPoint2d(s.sys, points[1].id)
    #let p1 = points[0].id.Point2d
    #let p2 = points[1].id.Point2d
    distance(p1,p2, distance, workplane, group)    

proc length*[N:SomeNumber](s:Segment; distance:N):Slvs_Constraint {.discardable.} =
  length(s, distance, s.sys.currentWorkplane, s.sys.currentGroup)


# cDistancePtLine: distance between point and segment
# ---------------------------------------------------
proc distance*[N:SomeNumber; P:Point3d | Point2d;T:Segment](point:P; line:T; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint {.discardable.} = 
  var sys = point.sys
  newConstraint( sys, cDistancePtLine, distance,
                 #point, 0.Point3d, line, 0.IdEntity, workplane, group )
                 point.id, 0.IdEntity, line, 0.IdEntity, workplane, group )

proc distance*[N:SomeNumber; P:Point3d | Point2d;T:Segment](point:P; line:T; distance:N):Slvs_Constraint {.discardable.} = 
  ##[
    The distance from point ptA to line segment entityA is equal to valA.

    May be used in 3d or projected into a workplane:

    - If the constraint is projected, then valA is a signed distance;
    positive versus negative valA correspond to a point that is above
    vs. below the line.

    - If the constraint applies in 3d, then valA must always be positive.


  ]##
  distance(point, line, distance, point.sys.currentWorkplane, point.sys.currentGroup ) 


# cProjPtDistance: distance between two points projected on an entity
proc projectedDistance*[N:SomeNumber; P1,P2:Point3d | Point2d](p1:P1; p2:P2; entity:IdEntity; distance:N):Slvs_Constraint {.discardable.} =
  ##[
    The distance between points ptA and ptB, as projected along the line
    or normal entityA, is equal to valA. This is a signed distance.

    Current Workplane is ignored 
  ]##
  var sys = p1.sys
  newConstraint( sys, cProjPtDistance, distance,
                 p1.id, p2.id, entity, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )


# cDistancePtPlane: 
proc distance*[N:SomeNumber; P:Point3d | Point2d](p:P; wrkpl:Workplane; distance:N):Slvs_Constraint {.discardable.} =
  ##[
    The distance from point ptA to workplane entityA is equal to
    valA. This is a signed distance; positive versus negative valA
    correspond to a point that is above vs. below the plane.

    Current Workplane is ignored 
  ]##
  var sys = p.sys
  newConstraint( sys, cDistancePtPlane, distance,
                 p.id, 0.IdEntity, wrkpl.id, 0.IdEntity, sys.currentWorkplane, sys.currentGroup )

# cEqPtLnDistances
proc distanceEqual*[N:SomeNumber; P1,P2:Point3d | Point2d; T:Segment | Normal3d](p1:P1; p2:P2; line:T):Slvs_Constraint {.discardable.} =
  ##[
    The distance between points ptA and ptB, as projected along the line
    or normal entityA, is equal to valA. This is a signed distance.

    Current Workplane is ignored 
  ]##
  var sys = p1.sys
  newConstraint( sys, cEqPtLnDistances, 0.0,
                 p1.id, p2.id, line.id, 0.id, sys.currentWorkplane, sys.currentGroup )