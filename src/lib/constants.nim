import ../wrapper/slvs
import types

const
  SLVS_RESULT_OKAY*              = 0
  SLVS_RESULT_INCONSISTENT*      = 1
  SLVS_RESULT_DIDNT_CONVERGE*    = 2
  SLVS_RESULT_TOO_MANY_UNKNOWNS* = 3


#const #WorkplaneEnum* = enum
#let wpFree*:Workplane 
#wpFree.id = SLVS_FREE_IN_3D

const
  wpFree* = SLVS_FREE_IN_3D

type
  Result* = enum
    rOK              = SLVS_RESULT_OKAY, 
    rInconsistent    = SLVS_RESULT_INCONSISTENT, 
    rConverge        = SLVS_RESULT_DIDNT_CONVERGE, 
    rTooManyUnknowns = SLVS_RESULT_TOO_MANY_UNKNOWNS

  ConstraintType* = enum
    cCoincidentPoints = SLVS_C_POINTS_COINCIDENT,
    cDistancePtPt     = SLVS_C_PT_PT_DISTANCE,     # DONE
    cDistancePtPlane  = SLVS_C_PT_PLANE_DISTANCE,
    cDistancePtLine   = SLVS_C_PT_LINE_DISTANCE,   # DONE
    cDistancePtFace   = SLVS_C_PT_FACE_DISTANCE,
    cPtInPlane        = SLVS_C_PT_IN_PLANE,
    cPtOnLine         = SLVS_C_PT_ON_LINE,
    cPtOnFace         = SLVS_C_PT_ON_FACE,
    cEqualLengthLines = SLVS_C_EQUAL_LENGTH_LINES,
    cLengthRatio      = SLVS_C_LENGTH_RATIO,
    cEqLenPtLine      = SLVS_C_EQ_LEN_PT_LINE_D,
    cEqPtLnDistances  = SLVS_C_EQ_PT_LN_DISTANCES,
    cEqualAngle       = SLVS_C_EQUAL_ANGLE,
    cEqualLineArc     = SLVS_C_EQUAL_LINE_ARC_LEN,
    cSymmetric        = SLVS_C_SYMMETRIC,
    cSymmetricHoriz   = SLVS_C_SYMMETRIC_HORIZ,
    cSymmetricVert    = SLVS_C_SYMMETRIC_VERT,
    cSymmetricLine    = SLVS_C_SYMMETRIC_LINE,
    cAtMidpoint       = SLVS_C_AT_MIDPOINT,
    cHorizontal       = SLVS_C_HORIZONTAL,
    cVertical         = SLVS_C_VERTICAL,         # DONE
    cDiameter         = SLVS_C_DIAMETER,         # DONE
    cPtOnCircle       = SLVS_C_PT_ON_CIRCLE,
    cSameOrientation  = SLVS_C_SAME_ORIENTATION,
    cAngle            = SLVS_C_ANGLE,
    cParallel         = SLVS_C_PARALLEL,
    cPerpendicular    = SLVS_C_PERPENDICULAR,
    cArcLineTangent   = SLVS_C_ARC_LINE_TANGENT,
    cCubicLineTangent = SLVS_C_CUBIC_LINE_TANGENT,
    cEqualRadius      = SLVS_C_EQUAL_RADIUS,       # DONE
    cProjPtDistance   = SLVS_C_PROJ_PT_DISTANCE,
    cWhereDragged     = SLVS_C_WHERE_DRAGGED,
    cCurveCurveTangent = SLVS_C_CURVE_CURVE_TANGENT,
    cLengthDifference  = SLVS_C_LENGTH_DIFFERENCE