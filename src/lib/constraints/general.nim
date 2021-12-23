import ../../wrapper/slvs
import ../types, ../constants#, point2d, point3d


# Constraints
proc newConstraint*[N:SomeNumber]( sys:var System; 
                     constraintType:ConstraintType; valA:N;  
                     p1,p2,e1,e2:IdEntity;
                     #p1:P1 = 0; p2:P2 = 0;
                     #e1:IdEntity = 0; e2:IdEntity = 0;
                     workplane:Workplane; group:IdGroup; other:bool = false ):Slvs_Constraint {.discardable.} =
  result = Slvs_MakeConstraint( sys.constraintNewId.Slvs_hConstraint, group.Slvs_hGroup,
                                          constraintType.cint, workplane.Slvs_hEntity,
                                          valA.cfloat, 
                                          p1.Slvs_hEntity, p2.Slvs_hEntity, 
                                          e1.Slvs_hEntity, e2.Slvs_hEntity )
  result.other = other.cint
  sys.constraintNewId += 1
  sys.constraints &= result


proc newConstraint*( sys:var System; 
                     constraintType:ConstraintType;  
                     line1,line2,line3,line4:Segment;
                     other:bool = false):Slvs_Constraint {.discardable.} =
  result = Slvs_MakeConstraint( sys.constraintNewId.Slvs_hConstraint, sys.currentGroup.Slvs_hGroup,
                                          constraintType.cint, sys.currentWorkplane.Slvs_hEntity,
                                          0.0, 
                                          0.Slvs_hEntity, 0.Slvs_hEntity, 
                                          0.Slvs_hEntity, 0.Slvs_hEntity )
  result.entityA = line1.id
  result.entityB = line2.id
  result.entityC = line3.id
  result.entityD = line4.id
  result.other   = other.cint  
  sys.constraintNewId += 1
  sys.constraints &= result