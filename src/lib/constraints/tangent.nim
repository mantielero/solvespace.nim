import ../../wrapper/slvs
import ../types, ../constants
import general



# cArcLineTangent
# ------
proc tangent*(arc:ArcOfCircle; line:Segment; other:bool = false):Slvs_Constraint {.discardable.} = 
  ##[
    The arc entityA is tangent to the line entityB. If other is false,
    then the arc is tangent at its beginning (point[1]). If other is true,
    then the arc is tangent at its end (point[2]).

  Must always be used with a workplane
  ]##
  var sys = line.sys
  result = newConstraint( sys, cAngle, 0.0,
                 0.IdEntity, 0.IdEntity, line.id, arc.id, sys.currentWorkplane, sys.currentGroup, other )
  #result.other = other.cint


# cCubicLineTangent
# -----------------
proc tangent*(arc:Cubic; line:Segment; other:bool = false):Slvs_Constraint {.discardable.} = 
  ##[
    The cubic entityA is tangent to the line entityB. The variable
    other indicates:

        if false: the cubic is tangent at its beginning
        if true:  the cubic is tangent at its end

    The beginning of the cubic is point[0], and the end is point[3].

  May be used in 3d or projected into a workplane.
  ]##
  var sys = line.sys
  result = newConstraint( sys, cCubicLineTangent, 0.0,
                 0.IdEntity, 0.IdEntity, arc.id, line.id, sys.currentWorkplane, sys.currentGroup )
  result.other = other.cint


# cCurveCurveTangent
# ------------------
proc tangent*[T1,T2:Cubic | ArcOfCircle](curve1:T1; curve2:T2; other:bool = false):Slvs_Constraint {.discardable.} = 
  ##[
    The two entities entityA and entityB are tangent. These entities can
    each be either an arc or a cubic, in any combination. The flags
    other and other2 indicate which endpoint of the curve is tangent,
    for entityA and entityB respectively:

        if false: the entity is tangent at its beginning
        if true:  the entity is tangent at its end

    For cubics, point[0] is the beginning, and point[3] is the end. For
    arcs, point[1] is the beginning, and point[2] is the end.

  Ignore the wrkpl member
  ]##
  var sys = curve1.sys
  result = newConstraint( sys, cCurveCurveTangent, 0.0,
                 0.IdEntity, 0.IdEntity, curve1.id, curve2.id, sys.currentWorkplane, sys.currentGroup )
  result.other = other.cint

