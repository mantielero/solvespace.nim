import ../../wrapper/slvs
import ../types, ../constants, ../point2d, ../point3d
import general

# Equal Radius
proc equalRadius*[T1,T2:Circle | ArcOfCircle](circle1:T1; circle2:T2; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint {.discardable.} =
  var sys = circle1.sys
  newConstraint( sys, cEqualRadius, 0.0, 0.IdEntity, 0.IdEntity, circle1.IdEntity, circle2.IdEntity, workplane, group )        

proc equalRadius*[T1,T2:Circle | ArcOfCircle](circle1:T1; circle2:T2):Slvs_Constraint {.discardable.} =
  equalRadius(circle1, circle2, circle1.sys.currentWorkplane, circle1.sys.currentGroup) 


proc diameter*[T:Circle | ArcOfCircle, N:SomeNumber](circle:T; diameter:N; 
          workplane:Workplane; group:IdGroup):Slvs_Constraint {.discardable.} =
  var sys = circle.sys
  newConstraint( sys, cDiameter, diameter, 0.IdEntity, 0.IdEntity, circle.IdEntity, 0.IdEntity, workplane, group )   

proc diameter*[T:Circle | ArcOfCircle, N:SomeNumber](circle:T; diameter:N):Slvs_Constraint {.discardable.} =
  diameter(circle, diameter, circle.sys.currentWorkplane, circle.sys.currentGroup)

proc radius*[T:Circle | ArcOfCircle, N:SomeNumber](circle:T; diameter:N):Slvs_Constraint {.discardable.} =
  diameter(circle, diameter.float * 2.0, circle.sys.currentWorkplane, circle.sys.currentGroup)