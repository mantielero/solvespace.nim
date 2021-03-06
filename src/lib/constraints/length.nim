import ../../wrapper/slvs
import ../types, ../constants
import general

# cEqualLengthLines:
# -------------------------
proc equalLength*(line1, line2:Segment):Slvs_Constraint {.discardable.} = 
  ##[
  The lines entityA and entityB have equal length.

  May be used in 3d or projected into a workplane
  ]##
  var sys = line1.sys
  newConstraint( sys, cEqualLengthLines, 0.0,
                 #point, 0.Point3d, line, 0.IdEntity, workplane, group )
                 0.IdEntity, 0.IdEntity, line1.id, line2.id, sys.currentWorkplane, sys.currentGroup )

# cLengthRatio
# ------------
proc lengthRatio*[N:SomeNumber](line1, line2:Segment; ratio:N):Slvs_Constraint {.discardable.} = 
  ##[
  The length of line entityA divided by the length of line entityB is
    equal to valA.

  May be used in 3d or projected into a workplane
  ]##
  var sys = line1.sys
  newConstraint( sys, cLengthRatio, ratio,
                 #point, 0.Point3d, line, 0.IdEntity, workplane, group )
                 0.IdEntity, 0.IdEntity, line1.id, line2.id, sys.currentWorkplane, sys.currentGroup )


# cLengthDifference
# -----------------
proc lengthDiff*[N:SomeNumber](line1, line2:Segment; diff:N):Slvs_Constraint {.discardable.} = 
  ##[
  The lengths of line entityA and line entityB differ by valA.

  May be used in 3d or projected into a workplane
  ]##
  var sys = line1.sys
  newConstraint( sys, cLengthDifference, diff,
                 #point, 0.Point3d, line, 0.IdEntity, workplane, group )
                 0.IdEntity, 0.IdEntity, line1.id, line2.id, sys.currentWorkplane, sys.currentGroup )

    
# cEqLenPtLine
# ------------
proc equalDistance*[P:Point3d | Point2d](point:P; line1:Segment;  line2:Segment):Slvs_Constraint {.discardable.} = 
  ##[
  The distance from the line entityA to the point ptA is equal to the
    distance from the line entityB to the point ptB.

  May be used in 3d or projected into a workplane
  ]##
  var sys = point.sys
  newConstraint( sys, cEqLenPtLine, 0.0,
                 point.id, 0.IdEntity, line1.id, line2.id, sys.currentWorkplane, sys.currentGroup )

# cEqualLineArc
proc equalLength*(line:Segment; arc:ArcOfCircle):Slvs_Constraint {.discardable.} = 
  ##[
  The length of the line entityA is equal to the length of the circular
    arc entityB.

  May be used in 3d or projected into a workplane
  ]##
  var sys = line.sys
  newConstraint( sys, cEqualLineArc, 0.0,
                 0.IdEntity, 0.IdEntity, line.id, arc.id, sys.currentWorkplane, sys.currentGroup )
