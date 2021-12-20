import ../wrapper/slvs
import types, constants, point2d, point3d

# Constraints
proc newConstraint*[N:SomeNumber]( sys:var System; 
                     constraintType:ConstraintType; valA:N;  
                     p1,p2,e1,e2:IdEntity;
                     #p1:P1 = 0; p2:P2 = 0;
                     #e1:IdEntity = 0; e2:IdEntity = 0;
                     workplane:Workplane; group:IdGroup ):Slvs_Constraint =
  result = Slvs_MakeConstraint( sys.constraintNewId.Slvs_hConstraint, group.Slvs_hGroup,
                                          constraintType.cint, workplane.Slvs_hEntity,
                                          valA.cfloat, 
                                          p1.Slvs_hEntity, p2.Slvs_hEntity, 
                                          e1.Slvs_hEntity, e2.Slvs_hEntity )
  sys.constraintNewId += 1
  sys.constraints &= result


# Distance
proc fixDistance*[N:SomeNumber; P1,P2:Point3d | Point2d](p1:P1; p2:P2; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint = 
  var sys = p1.sys
  newConstraint( sys, cDistancePtPt, distance,
                 p1.id, p2.id, 0.IdEntity, 0.IdEntity, workplane, group )

proc fixDistance*[N:SomeNumber; P1,P2:Point3d | Point2d](p1:P1; p2:P2; distance:N):Slvs_Constraint =
  fixDistance(p1, p2, distance, p1.sys.currentWorkplane, p1.sys.currentGroup)

proc fixDistance*[N:SomeNumber](s:Segment; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint = 
  let points = s.sys.getPoints(s)
  if points[0].typ == SLVS_E_POINT_IN_3D:
    #[     let p1 = points[0].id.Point3d
    let p2 = points[1].id.Point3d ]#
    var p1:Point3d
    p1.id = points[0].id
    p1.sys = s.sys
    var p2:Point3d
    p2.id = points[1].id
    p2.sys = s.sys    

    fixDistance(p1,p2, distance, workplane, group)
  else:
    let p1 = toPoint2d(s.sys, points[0].id)
    let p2 = toPoint2d(s.sys, points[1].id)
    #let p1 = points[0].id.Point2d
    #let p2 = points[1].id.Point2d
    fixDistance(p1,p2, distance, workplane, group)    

proc fixDistance*[N:SomeNumber](s:Segment; distance:N):Slvs_Constraint =
  fixDistance(s, distance, s.sys.currentWorkplane, s.sys.currentGroup)

proc fixDistance*[N:SomeNumber; P:Point3d | Point2d;T:Segment](point:P; line:T; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint = 
  var sys = point.sys
  newConstraint( sys, cDistancePtLine, distance,
                 #point, 0.Point3d, line, 0.IdEntity, workplane, group )
                 point.id, 0.IdEntity, line, 0.IdEntity, workplane, group )

proc fixDistance*[N:SomeNumber; P:Point3d | Point2d;T:Segment](point:P; line:T; distance:N):Slvs_Constraint = 
  fixDistance(point, line, distance, point.sys.currentWorkplane, point.sys.currentGroup ) 


# Vertical
proc vertical*[T:Segment](line:T; 
          workplane:Workplane; group:IdGroup ):Slvs_Constraint =
  var sys = line.sys
  newConstraint( sys, cVertical, 0.0, 0.IdEntity, 0.IdEntity, line.IdEntity, 0.IdEntity, workplane, group )  

proc vertical*[T:Segment](line:T):Slvs_Constraint =
  vertical(line, line.sys.currentWorkplane, line.sys.currentGroup)

# Equal Radius
proc equalRadius*[T1,T2:Circle | ArcOfCircle](circle1:T1; circle2:T2; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint =
  var sys = circle1.sys
  newConstraint( sys, cEqualRadius, 0.0, 0.IdEntity, 0.IdEntity, circle1.IdEntity, circle2.IdEntity, workplane, group )        

proc equalRadius*[T1,T2:Circle | ArcOfCircle](circle1:T1; circle2:T2):Slvs_Constraint =
  equalRadius(circle1, circle2, circle1.sys.currentWorkplane, circle1.sys.currentGroup) 


proc diameter*[T:Circle | ArcOfCircle, N:SomeNumber](circle:T; diameter:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint =
  var sys = circle.sys
  newConstraint( sys, cDiameter, diameter, 0.IdEntity, 0.IdEntity, circle.IdEntity, 0.IdEntity, workplane, group )   

proc diameter*[T:Circle | ArcOfCircle, N:SomeNumber](circle:T; diameter:N):Slvs_Constraint =
  diameter(circle, diameter, circle.sys.currentWorkplane, circle.sys.currentGroup)

proc radius*[T:Circle | ArcOfCircle, N:SomeNumber](circle:T; diameter:N):Slvs_Constraint =
  diameter(circle, diameter.float * 2.0, circle.sys.currentWorkplane, circle.sys.currentGroup)