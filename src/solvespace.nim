const libPath  = "/usr/lib/solvespace"
const libName = "slvs"
{.passL: "-L" &  libPath.}
{.passL: "-Wl,-rpath," &  libPath.}
{.passL: "-l" &  libName.}

const
  SLVS_RESULT_OKAY*              = 0
  SLVS_RESULT_INCONSISTENT*      = 1
  SLVS_RESULT_DIDNT_CONVERGE*    = 2
  SLVS_RESULT_TOO_MANY_UNKNOWNS* = 3

import wrapper/slvs
export slvs


type
  Result* = enum
    rOK              = SLVS_RESULT_OKAY, 
    rInconsistent    = SLVS_RESULT_INCONSISTENT, 
    rConverge        = SLVS_RESULT_DIDNT_CONVERGE, 
    rTooManyUnknowns = SLVS_RESULT_TOO_MANY_UNKNOWNS

  Workplane* = enum
    wpFree = SLVS_FREE_IN_3D

  ConstraintType* = enum
    cCoincidentPoints = SLVS_C_POINTS_COINCIDENT,
    cDistancePtPt     = SLVS_C_PT_PT_DISTANCE,
    cDistancePtPlane  = SLVS_C_PT_PLANE_DISTANCE,
    cDistancePtLine   = SLVS_C_PT_LINE_DISTANCE, 
    cDistancePtFace   = SLVS_C_PT_FACE_DISTANCE,
    cPtInPlane        = SLVS_C_PT_IN_PLANE,
    cPtOnLine         = SLVS_C_PT_ON_LINE,
    cPtOnFace         = SLVS_C_PT_ON_FACE,
    cEqualLengthLines = SLVS_C_EQUAL_LENGTH_LINES,
    cLengthRatio      = SLVS_C_LENGTH_RATIO,
    cEqLenPtLine      = SLVS_C_EQ_LEN_PT_LINE_D
#[   SLVS_C_EQ_PT_LN_DISTANCES* = 100011
  SLVS_C_EQUAL_ANGLE* = 100012
  SLVS_C_EQUAL_LINE_ARC_LEN* = 100013
  SLVS_C_SYMMETRIC* = 100014
  SLVS_C_SYMMETRIC_HORIZ* = 100015
  SLVS_C_SYMMETRIC_VERT* = 100016
  SLVS_C_SYMMETRIC_LINE* = 100017
  SLVS_C_AT_MIDPOINT* = 100018
  SLVS_C_HORIZONTAL* = 100019
  SLVS_C_VERTICAL* = 100020
  SLVS_C_DIAMETER* = 100021
  SLVS_C_PT_ON_CIRCLE* = 100022
  SLVS_C_SAME_ORIENTATION* = 100023
  SLVS_C_ANGLE* = 100024
  SLVS_C_PARALLEL* = 100025
  SLVS_C_PERPENDICULAR* = 100026
  SLVS_C_ARC_LINE_TANGENT* = 100027
  SLVS_C_CUBIC_LINE_TANGENT* = 100028
  SLVS_C_EQUAL_RADIUS* = 100029
  SLVS_C_PROJ_PT_DISTANCE* = 100030
  SLVS_C_WHERE_DRAGGED* = 100031
  SLVS_C_CURVE_CURVE_TANGENT* = 100032
  SLVS_C_LENGTH_DIFFERENCE* = 100033
 ]#

type
  System* = object
    sys*:Slvs_System
    params*:seq[Slvs_Param]
    entities*:seq[Slvs_Entity]
    constraints*:seq[Slvs_Constraint]
    paramNewId:uint  ## Keeps track of the following identifier
    entityNewId:uint
    constraintNewId:uint

  Point3d* = object
    id*, xid*, yid*, zid*:uint

  Segment* = object
    id*, p1*, p2*:uint


proc newSystem*():System =
  result.paramNewId      = 1
  result.entityNewId     = 1001
  result.constraintNewId = 200001
  result.sys.dragged[0]      = 0 #p.xId.Slvs_hParam
  result.sys.dragged[1]      = 0 #p.yId.Slvs_hParam
  result.sys.dragged[2]      = 0 #p.zId.Slvs_hParam  
  result.sys.dragged[3]      = 0 

proc addPoint*[X,Y,Z:SomeNumber](sys:var System; group:uint; x:X; y:Y; z:Z):Point3d =
  sys.params &= Slvs_MakeParam(sys.paramNewId.Slvs_hParam, group.Slvs_hGroup, x.cdouble)
  result.xid = sys.paramNewId
  sys.paramNewId += 1
  sys.params &= Slvs_MakeParam(sys.paramNewId.Slvs_hParam, group.Slvs_hGroup, y.cdouble)
  result.yid = sys.paramNewId
  sys.paramNewId += 1
  sys.params &= Slvs_MakeParam(sys.paramNewId.Slvs_hParam, group.Slvs_hGroup, z.cdouble)
  result.zid = sys.paramNewId  
  sys.paramNewId += 1
  #echo p
  sys.entities &= Slvs_MakePoint3d(sys.entityNewId.Slvs_hEntity, group.Slvs_hGroup, result.xId.Slvs_hParam, result.yId.Slvs_hParam, result.zId.Slvs_hParam) 
  result.id = sys.entityNewId
  sys.entityNewId += 1  



proc newSegment*(sys:var System; group:uint; workplane:Workplane; p1,p2:Point3d ):Segment =
  var s:Segment
  sys.entities &= Slvs_MakeLineSegment( sys.entityNewId.Slvs_hEntity, group.Slvs_hGroup, 
                                        workplane.Slvs_hEntity, 
                                        p1.id.Slvs_hEntity, p2.id.Slvs_hEntity )
  s.id = sys.entityNewId
  s.p1 = p1.id
  s.p2 = p2.id
  sys.entityNewId += 1
  return s


# Constraints
proc newConstraint*[N:SomeNumber]( sys:var System; group:uint; workplane:Workplane; 
                     constraintType:ConstraintType; valA:N;  
                     p1:uint = 0; p2:uint = 0;
                     e1:uint = 0; e2:uint = 0 ):Slvs_Constraint =
  result = Slvs_MakeConstraint( sys.constraintNewId.Slvs_hConstraint, group.Slvs_hGroup,
                                          constraintType.cint, workplane.Slvs_hEntity,
                                          valA.cfloat, 
                                          p1.Slvs_hEntity, p2.Slvs_hEntity, 
                                          e1.Slvs_hEntity, e2.Slvs_hEntity )
  sys.constraintNewId += 1
  sys.constraints &= result



proc constrainDistance*[N:SomeNumber](sys:var System; group:uint; workplane:Workplane; p1,p2:Point3d; distance:N):Slvs_Constraint = 
  newConstraint( sys, group, workplane, 
                 cDistancePtPt, distance,
                 p1.id, p2.id )


#--------

proc drag*( sys:var System; p:Point3d) =
  echo p
  sys.sys.dragged[0] = p.xid.Slvs_hParam
  sys.sys.dragged[1] = p.yid.Slvs_hParam
  sys.sys.dragged[2] = p.zid.Slvs_hParam


#-----
proc `$`*(p:Slvs_Param):string =
  return "Param: entity=" & $p.h & " group=" & $p.group & " val=" & $p.val 

proc `$`(s:Slvs_System):string =
  result = "SYSTEM:\n"
  result &= "  PARAMS:\n"
  for i in 0 ..< s.params:
    result &= "    " & $s.param[i] & "\n"
  result &= "  ENTITIES:\n"
  for i in 0 ..< s.entities:
    result &= "    " & $s.entity[i] & "\n"  
  result &= "  CONSTRAINTS:\n"
  for i in 0 ..< s.constraints:
    result &= "    " & $s.constraint[i] & "\n"

proc solve*( s:var System; group:uint ):Result =
  s.sys.params      = s.params.len.cint
  s.sys.entities    = s.entities.len.cint
  s.sys.constraints = s.constraints.len.cint
  s.sys.param       = cast[ptr UncheckedArray[Slvs_Param]](s.params[0].unsafeAddr)
  s.sys.entity      = cast[ptr UncheckedArray[Slvs_Entity]](s.entities[0].unsafeAddr)
  s.sys.constraint  = cast[ptr UncheckedArray[Slvs_Constraint]](s.constraints[0].unsafeAddr)  

  echo s.sys

  Slvs_Solve(cast[ptr Slvs_System](s.sys.unsafeAddr), group.Slvs_hGroup )  # Slvs_Solve(sys.unsafeAddr, g)

  echo s.sys  

  result = case s.sys.result:
            of SLVS_RESULT_OKAY:              rOK
            of SLVS_RESULT_INCONSISTENT:      rInconsistent
            of SLVS_RESULT_DIDNT_CONVERGE:    rConverge
            of SLVS_RESULT_TOO_MANY_UNKNOWNS: rTooManyUnknowns
            else:
              raise newException(ValueError, "the solver is returning an unknown value")


