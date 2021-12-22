import ../../wrapper/slvs
import ../types, ../constants#, point2d, point3d
import general

# Vertical
proc vertical*[T:Segment](line:T; 
          workplane:Workplane; group:IdGroup ):Slvs_Constraint {.discardable.} =
  var sys = line.sys
  newConstraint( sys, cVertical, 0.0, 0.IdEntity, 0.IdEntity, line.IdEntity, 0.IdEntity, workplane, group )  

proc vertical*[T:Segment](line:T):Slvs_Constraint {.discardable.} =
  vertical(line, line.sys.currentWorkplane, line.sys.currentGroup)