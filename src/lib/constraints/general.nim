import ../../wrapper/slvs
import ../types, ../constants#, point2d, point3d


# Constraints
proc newConstraint*[N:SomeNumber]( sys:var System; 
                     constraintType:ConstraintType; valA:N;  
                     p1,p2,e1,e2:IdEntity;
                     #p1:P1 = 0; p2:P2 = 0;
                     #e1:IdEntity = 0; e2:IdEntity = 0;
                     workplane:Workplane; group:IdGroup ):Slvs_Constraint {.discardable.} =
  result = Slvs_MakeConstraint( sys.constraintNewId.Slvs_hConstraint, group.Slvs_hGroup,
                                          constraintType.cint, workplane.Slvs_hEntity,
                                          valA.cfloat, 
                                          p1.Slvs_hEntity, p2.Slvs_hEntity, 
                                          e1.Slvs_hEntity, e2.Slvs_hEntity )
  sys.constraintNewId += 1
  sys.constraints &= result