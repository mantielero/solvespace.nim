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
    cCoincidentPoints = SLVS_C_POINTS_COINCIDENT,  # DONE
    cDistancePtPt     = SLVS_C_PT_PT_DISTANCE,     # DONE
    cDistancePtPlane  = SLVS_C_PT_PLANE_DISTANCE,  # DONE
    cDistancePtLine   = SLVS_C_PT_LINE_DISTANCE,   # DONE
    cDistancePtFace   = SLVS_C_PT_FACE_DISTANCE,   # DOCUMENTATION NOT FOUND
    cPtInPlane        = SLVS_C_PT_IN_PLANE,        # DONE
    cPtOnLine         = SLVS_C_PT_ON_LINE,         # DONE
    cPtOnFace         = SLVS_C_PT_ON_FACE,         # DOCUMENTATION NOT FOUND
    cEqualLengthLines = SLVS_C_EQUAL_LENGTH_LINES, # DONE
    cLengthRatio      = SLVS_C_LENGTH_RATIO,       # DONE
    cEqLenPtLine      = SLVS_C_EQ_LEN_PT_LINE_D,   # DONE
    cEqPtLnDistances  = SLVS_C_EQ_PT_LN_DISTANCES, # DONE
    cEqualAngle       = SLVS_C_EQUAL_ANGLE,        # DONE
    cEqualLineArc     = SLVS_C_EQUAL_LINE_ARC_LEN, # DONE
    cSymmetric        = SLVS_C_SYMMETRIC,          # DONE
    cSymmetricHoriz   = SLVS_C_SYMMETRIC_HORIZ,    # DONE
    cSymmetricVert    = SLVS_C_SYMMETRIC_VERT,     # DONE
    cSymmetricLine    = SLVS_C_SYMMETRIC_LINE,     # DONE
    cAtMidpoint       = SLVS_C_AT_MIDPOINT,        # DONE
    cHorizontal       = SLVS_C_HORIZONTAL,         # DONE
    cVertical         = SLVS_C_VERTICAL,           # DONE
    cDiameter         = SLVS_C_DIAMETER,           # DONE
    cPtOnCircle       = SLVS_C_PT_ON_CIRCLE,       # DONE
    cSameOrientation  = SLVS_C_SAME_ORIENTATION,   # DONE
    cAngle            = SLVS_C_ANGLE,              # DONE
    cParallel         = SLVS_C_PARALLEL,           # DONE
    cPerpendicular    = SLVS_C_PERPENDICULAR,      # DONE
    cArcLineTangent   = SLVS_C_ARC_LINE_TANGENT,   # DONE
    cCubicLineTangent = SLVS_C_CUBIC_LINE_TANGENT, # DONE
    cEqualRadius      = SLVS_C_EQUAL_RADIUS,       # DONE
    cProjPtDistance   = SLVS_C_PROJ_PT_DISTANCE,   # DONE
    cWhereDragged     = SLVS_C_WHERE_DRAGGED,      # DONE
    cCurveCurveTangent = SLVS_C_CURVE_CURVE_TANGENT, # DONE
    cLengthDifference  = SLVS_C_LENGTH_DIFFERENCE  # DONE