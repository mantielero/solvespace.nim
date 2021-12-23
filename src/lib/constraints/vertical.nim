import ../../wrapper/slvs
import ../types, ../constants
import general

# Vertical
proc vertical*[T:Segment](line:T; 
          workplane:Workplane; group:IdGroup ):Slvs_Constraint {.discardable.} =
  var sys = line.sys
  newConstraint( sys, cVertical, 0.0, 0.IdEntity, 0.IdEntity, line.IdEntity, 0.IdEntity, workplane, group )  

proc vertical*[T:Segment](line:T):Slvs_Constraint {.discardable.} =
  ##[
  The line is vertical.

  It will use the current workplane
  ]##  
  vertical(line, line.sys.currentWorkplane, line.sys.currentGroup)