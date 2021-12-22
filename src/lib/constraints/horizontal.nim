import ../../wrapper/slvs
import ../types, ../constants#, point2d, point3d
import general

# Horizontal
# cHorizontal
# -----------
proc horizontal*[T:Segment](line:T; 
          workplane:Workplane; group:IdGroup ):Slvs_Constraint {.discardable.} =
  ##[
      The line connecting points ptA and ptB is horizontal or vertical. Or,
    the line segment entityA is horizontal or vertical. If points are
    specified then the line segment should be left zero, and if a line
    is specified then the points should be left zero.

  Must always be used with a workplane
  ]##
  var sys = line.sys
  newConstraint( sys, cHorizontal, 0.0, 0.IdEntity, 0.IdEntity, line.IdEntity, 0.IdEntity, workplane, group )  

proc horizontal*[T:Segment](line:T):Slvs_Constraint {.discardable.} =
  horizontal(line, line.sys.currentWorkplane, line.sys.currentGroup)