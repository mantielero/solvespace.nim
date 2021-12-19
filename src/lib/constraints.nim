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



proc constrainDistance*[N:SomeNumber; P1,P2:Point3d | Point2d](sys:var System; p1:P1; p2:P2; distance:N; 
          workplane:Workplane = wpFree; group:IdGroup = 0):Slvs_Constraint = 
  newConstraint( sys, cDistancePtPt, distance,
                 p1, p2, 0.IdEntity, 0.IdEntity, workplane, group )

proc constrainDistance*[N:SomeNumber](sys:var System; s:Segment; distance:N; 
          workplane:Workplane = wpFree; group:IdGroup = 0):Slvs_Constraint = 
  let points = sys.getPoints(s)
  if points[0].typ == SLVS_E_POINT_IN_3D:
    let p1 = points[0].id.Point3d
    let p2 = points[1].id.Point3d
    sys.constrainDistance(p1,p2, distance, workplane, group)
  else:
    let p1 = points[0].id.Point2d
    let p2 = points[1].id.Point2d
    sys.constrainDistance(p1,p2, distance, workplane, group)    


proc constrainDistance*[N:SomeNumber; P:Point3d | Point2d;T:Segment](sys:var System; point:P; line:T; distance:N; 
          workplane:Workplane = wpFree; group:IdGroup = 0):Slvs_Constraint = 
  newConstraint( sys, cDistancePtLine, distance,
                 point, 0.Point3d, line, 0.IdEntity, workplane, group )

proc constrainVertical*[T:Segment](sys:var System; line:T; 
          workplane:Workplane = wpFree; group:IdGroup = 0):Slvs_Constraint =
  newConstraint( sys, cVertical, 0.0, 0.Point3d, 0.Point3d, line.IdEntity, 0.IdEntity, workplane, group )  




proc constrainEqualRadius*[T1,T2:Circle | ArcOfCircle](sys:var System; circle1:T1; circle2:T2; 
          workplane:Workplane = wpFree; group:IdGroup = 0):Slvs_Constraint =
  newConstraint( sys, cEqualRadius, 0.0, 0.Point3d, 0.Point3d, circle1.IdEntity, circle2.IdEntity, workplane, group )        


proc constrainDiameter*[T:Circle | ArcOfCircle, N:SomeNumber](sys:var System; circle:T; diameter:N; 
          workplane:Workplane = wpFree; group:IdGroup = 0):Slvs_Constraint =
  newConstraint( sys, cDiameter, diameter, 0.Point3d, 0.Point3d, circle.IdEntity, 0.IdEntity, workplane, group )   
#[
    /* And the line segment is vertical. */
    sys.constraint[sys.constraints++] = Slvs_MakeConstraint(
                                            3, g,
                                            SLVS_C_VERTICAL,
                                            200,
                                            0.0,
                                            0, 0, 400, 0);
]#