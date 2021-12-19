import ../wrapper/slvs
import types, constants

# Constraints
proc newConstraint*[N:SomeNumber;P1,P2:Point2d | Point3d]( sys:var System; 
                     constraintType:ConstraintType; valA:N;  
                     p1:P1 = 0; p2:P2 = 0;
                     e1:IdEntity = 0; e2:IdEntity = 0;
                     workplane:Workplane = wpFree; group:uint = 0 ):Slvs_Constraint =
  result = Slvs_MakeConstraint( sys.constraintNewId.Slvs_hConstraint, group.Slvs_hGroup,
                                          constraintType.cint, workplane.Slvs_hEntity,
                                          valA.cfloat, 
                                          p1.Slvs_hEntity, p2.Slvs_hEntity, 
                                          e1.Slvs_hEntity, e2.Slvs_hEntity )
  sys.constraintNewId += 1
  sys.constraints &= result


# Distance
proc constrainDistance*[N:SomeNumber; P1,P2:Point3d | Point2d](sys:var System; p1:P1; p2:P2; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint = 
  newConstraint( sys, cDistancePtPt, distance,
                 p1, p2, 0.IdEntity, 0.IdEntity, workplane, group )

proc constrainDistance*[N:SomeNumber; P1,P2:Point3d | Point2d](sys:var System; p1:P1; p2:P2; distance:N):Slvs_Constraint =
  constrainDistance(sys, p1, p2, distance, sys.currentWorkplane, sys.currentGroup)

proc constrainDistance*[N:SomeNumber](sys:var System; s:Segment; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint = 
  let points = sys.getPoints(s)
  if points[0].typ == SLVS_E_POINT_IN_3D:
    let p1 = points[0].id.Point3d
    let p2 = points[1].id.Point3d
    sys.constrainDistance(p1,p2, distance, workplane, group)
  else:
    let p1 = points[0].id.Point2d
    let p2 = points[1].id.Point2d
    sys.constrainDistance(p1,p2, distance, workplane, group)    

proc constrainDistance*[N:SomeNumber](sys:var System; s:Segment; distance:N):Slvs_Constraint =
  constrainDistance(sys, s, distance, sys.currentWorkplane, sys.currentGroup)

proc constrainDistance*[N:SomeNumber; P:Point3d | Point2d;T:Segment](sys:var System; point:P; line:T; distance:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint = 
  newConstraint( sys, cDistancePtLine, distance,
                 point, 0.Point3d, line, 0.IdEntity, workplane, group )

proc constrainDistance*[N:SomeNumber; P:Point3d | Point2d;T:Segment](sys:var System; point:P; line:T; distance:N):Slvs_Constraint = 
  constrainDistance(sys, point, line, distance, sys.currentWorkplane, sys.currentGroup ) 


# Vertical
proc constrainVertical*[T:Segment](sys:var System; line:T; 
          workplane:Workplane; group:IdGroup ):Slvs_Constraint =
  newConstraint( sys, cVertical, 0.0, 0.Point3d, 0.Point3d, line.IdEntity, 0.IdEntity, workplane, group )  

proc constrainVertical*[T:Segment](sys:var System; line:T):Slvs_Constraint =
  constrainVertical(sys, line, sys.currentWorkplane, sys.currentGroup)

# Equal Radius
proc constrainEqualRadius*[T1,T2:Circle | ArcOfCircle](sys:var System; circle1:T1; circle2:T2; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint =
  newConstraint( sys, cEqualRadius, 0.0, 0.Point3d, 0.Point3d, circle1.IdEntity, circle2.IdEntity, workplane, group )        

proc constrainEqualRadius*[T1,T2:Circle | ArcOfCircle](sys:var System; circle1:T1; circle2:T2):Slvs_Constraint =
  constrainEqualRadius(sys, circle1, circle2, sys.currentWorkplane, sys.currentGroup) 


proc constrainDiameter*[T:Circle | ArcOfCircle, N:SomeNumber](sys:var System; circle:T; diameter:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint =
  newConstraint( sys, cDiameter, diameter, 0.Point3d, 0.Point3d, circle.IdEntity, 0.IdEntity, workplane, group )   

proc constrainDiameter*[T:Circle | ArcOfCircle, N:SomeNumber](sys:var System; circle:T; diameter:N):Slvs_Constraint =
  constrainDiameter(sys, circle, diameter, sys.currentWorkplane, sys.currentGroup)