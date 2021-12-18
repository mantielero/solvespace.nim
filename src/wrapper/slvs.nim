# Generated @ 2021-12-15T14:30:12+01:00
# Command line:
#   /home/jose/.nimble/pkgs/nimterop-0.6.13/nimterop/toast -pns --prefix:__,_ --suffix:__,_ /usr/include/slvs.h

{.push hint[ConvFromXtoItselfNotNeeded]: off.}


{.pragma: impslvsHdr, header: "/usr/include/slvs.h".}
{.experimental: "codeReordering".}
const
  SLVS_FREE_IN_3D* = 0
  
  SLVS_E_POINT_IN_3D* = 50000
  SLVS_E_POINT_IN_2D* = 50001
  SLVS_E_NORMAL_IN_3D* = 60000
  SLVS_E_NORMAL_IN_2D* = 60001
  SLVS_E_DISTANCE* = 70000
  SLVS_E_WORKPLANE* = 80000
  SLVS_E_LINE_SEGMENT* = 80001
  SLVS_E_CUBIC* = 80002
  SLVS_E_CIRCLE* = 80003
  SLVS_E_ARC_OF_CIRCLE* = 80004

  SLVS_C_POINTS_COINCIDENT* = 100000
  SLVS_C_PT_PT_DISTANCE* = 100001
  SLVS_C_PT_PLANE_DISTANCE* = 100002
  SLVS_C_PT_LINE_DISTANCE* = 100003
  SLVS_C_PT_FACE_DISTANCE* = 100004
  SLVS_C_PT_IN_PLANE* = 100005
  SLVS_C_PT_ON_LINE* = 100006
  SLVS_C_PT_ON_FACE* = 100007
  SLVS_C_EQUAL_LENGTH_LINES* = 100008
  SLVS_C_LENGTH_RATIO* = 100009
  SLVS_C_EQ_LEN_PT_LINE_D* = 100010
  SLVS_C_EQ_PT_LN_DISTANCES* = 100011
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
  
type
  Slvs_hParam* {.importc, impslvsHdr.} = uint32
  Slvs_hEntity* {.importc, impslvsHdr.} = uint32
  Slvs_hConstraint* {.importc, impslvsHdr.} = uint32
  Slvs_hGroup* {.importc, impslvsHdr.} = uint32
  Slvs_Param* {.bycopy, importc, impslvsHdr.} = object
    h*: Slvs_hParam
    group*: Slvs_hGroup
    val*: cdouble

  Slvs_Entity* {.bycopy, importc, impslvsHdr.} = object
    h*: Slvs_hEntity
    group*: Slvs_hGroup
    `type`*: cint
    wrkpl*: Slvs_hEntity
    point*: array[4, Slvs_hEntity]
    normal*: Slvs_hEntity
    distance*: Slvs_hEntity
    param*: array[4, Slvs_hParam]

  Slvs_Constraint* {.bycopy, importc, impslvsHdr.} = object
    h*: Slvs_hConstraint
    group*: Slvs_hGroup
    `type`*: cint
    wrkpl*: Slvs_hEntity
    valA*: cdouble
    ptA*: Slvs_hEntity
    ptB*: Slvs_hEntity
    entityA*: Slvs_hEntity
    entityB*: Slvs_hEntity
    entityC*: Slvs_hEntity
    entityD*: Slvs_hEntity
    other*: cint
    other2*: cint

  Slvs_System* {.bycopy, importc, impslvsHdr.} = object
    param*: ptr UncheckedArray[Slvs_Param]  #ptr Slvs_Param ## ```
                           ##   INPUT VARIABLES
                           ##       
                           ##        Here, we specify the parameters and their initial values, the entities,
                           ##        and the constraints. For example, param[] points to the array of
                           ##        parameters, which has length params, so that the last valid element
                           ##        is param[params-1].
                           ##       
                           ##        param[] is actually an in/out variable; if the solver is successful,
                           ##        then the new values (that satisfy the constraints) are written to it.
                           ## ```
    params*: cint
    entity*:  ptr UncheckedArray[Slvs_Entity]         #ptr Slvs_Entity
    entities*: cint
    constraint*: ptr UncheckedArray[Slvs_Constraint]  #ptr Slvs_Constraint
    constraints*: cint
    dragged*: array[4, Slvs_hParam] ## ```
                                    ##   If a parameter corresponds to a point (distance, normal, etc.) being
                                    ##        dragged, then specify it here. This will cause the solver to favor
                                    ##        that parameter, and attempt to change it as little as possible even
                                    ##        if that requires it to change other parameters more.
                                    ##       
                                    ##        Unused members of this array should be set to zero.
                                    ## ```
    calculateFaileds*: cint ## ```
                            ##   If the solver fails, then it can determine which constraints are
                            ##        causing the problem. But this is a relatively slow process (for
                            ##        a system with n constraints, about n times as long as just solving).
                            ##        If calculateFaileds is true, then the solver will do so, otherwise
                            ##        not.
                            ## ```
    failed*: ptr Slvs_hConstraint ## ```
                                  ##   OUTPUT VARIABLES
                                  ##       
                                  ##        If the solver fails, then it can report which constraints are causing
                                  ##        the problem. The caller should allocate the array failed[], and pass
                                  ##        its size in faileds.
                                  ##       
                                  ##        The solver will set faileds equal to the number of problematic
                                  ##        constraints, and write their Slvs_hConstraints into failed[]. To
                                  ##        ensure that there is sufficient space for any possible set of
                                  ##        failing constraints, faileds should be greater than or equal to
                                  ##        constraints.
                                  ## ```
    faileds*: cint
    dof*: cint ## ```
               ##   The solver indicates the number of unconstrained degrees of freedom.
               ## ```
    result*: cint

proc Slvs_Solve*(sys: ptr Slvs_System; hg: Slvs_hGroup) {.importc, cdecl,
    impslvsHdr.}
proc Slvs_QuaternionU*(qw: cdouble; qx: cdouble; qy: cdouble; qz: cdouble;
                       x: ptr cdouble; y: ptr cdouble; z: ptr cdouble) {.
    importc, cdecl, impslvsHdr.}
  ## ```
                                ##   Our base coordinate system has basis vectors
                                ##        (1, 0, 0)  (0, 1, 0)  (0, 0, 1)
                                ##    A unit quaternion defines a rotation to a new coordinate system with
                                ##    basis vectors
                                ##            U          V          N
                                ##    which these functions compute from the quaternion.
                                ## ```
proc Slvs_QuaternionV*(qw: cdouble; qx: cdouble; qy: cdouble; qz: cdouble;
                       x: ptr cdouble; y: ptr cdouble; z: ptr cdouble) {.
    importc, cdecl, impslvsHdr.}
proc Slvs_QuaternionN*(qw: cdouble; qx: cdouble; qy: cdouble; qz: cdouble;
                       x: ptr cdouble; y: ptr cdouble; z: ptr cdouble) {.
    importc, cdecl, impslvsHdr.}
proc Slvs_MakeQuaternion*(ux: cdouble; uy: cdouble; uz: cdouble; vx: cdouble;
                          vy: cdouble; vz: cdouble; qw: ptr cdouble;
                          qx: ptr cdouble; qy: ptr cdouble; qz: ptr cdouble) {.
    importc, cdecl, impslvsHdr.}
  ## ```
                                ##   Similarly, compute a unit quaternion in terms of two basis vectors.
                                ## ```
proc Slvs_MakeParam*(h: Slvs_hParam; group: Slvs_hGroup; val: cdouble): Slvs_Param {.
    importc, cdecl, impslvsHdr.}
proc Slvs_MakePoint2d*(h: Slvs_hEntity; group: Slvs_hGroup; wrkpl: Slvs_hEntity;
                       u: Slvs_hParam; v: Slvs_hParam): Slvs_Entity {.importc,
    cdecl, impslvsHdr.}
proc Slvs_MakePoint3d*(h: Slvs_hEntity; group: Slvs_hGroup; x: Slvs_hParam;
                       y: Slvs_hParam; z: Slvs_hParam): Slvs_Entity {.importc,
    cdecl, impslvsHdr.}
proc Slvs_MakeNormal3d*(h: Slvs_hEntity; group: Slvs_hGroup; qw: Slvs_hParam;
                        qx: Slvs_hParam; qy: Slvs_hParam; qz: Slvs_hParam): Slvs_Entity {.
    importc, cdecl, impslvsHdr.}
proc Slvs_MakeNormal2d*(h: Slvs_hEntity; group: Slvs_hGroup; wrkpl: Slvs_hEntity): Slvs_Entity {.
    importc, cdecl, impslvsHdr.}
proc Slvs_MakeDistance*(h: Slvs_hEntity; group: Slvs_hGroup;
                        wrkpl: Slvs_hEntity; d: Slvs_hParam): Slvs_Entity {.
    importc, cdecl, impslvsHdr.}
proc Slvs_MakeLineSegment*(h: Slvs_hEntity; group: Slvs_hGroup;
                           wrkpl: Slvs_hEntity; ptA: Slvs_hEntity;
                           ptB: Slvs_hEntity): Slvs_Entity {.importc, cdecl,
    impslvsHdr.}
proc Slvs_MakeCubic*(h: Slvs_hEntity; group: Slvs_hGroup; wrkpl: Slvs_hEntity;
                     pt0: Slvs_hEntity; pt1: Slvs_hEntity; pt2: Slvs_hEntity;
                     pt3: Slvs_hEntity): Slvs_Entity {.importc, cdecl,
    impslvsHdr.}
proc Slvs_MakeArcOfCircle*(h: Slvs_hEntity; group: Slvs_hGroup;
                           wrkpl: Slvs_hEntity; normal: Slvs_hEntity;
                           center: Slvs_hEntity; start: Slvs_hEntity;
                           `end`: Slvs_hEntity): Slvs_Entity {.importc, cdecl,
    impslvsHdr.}
proc Slvs_MakeCircle*(h: Slvs_hEntity; group: Slvs_hGroup; wrkpl: Slvs_hEntity;
                      center: Slvs_hEntity; normal: Slvs_hEntity;
                      radius: Slvs_hEntity): Slvs_Entity {.importc, cdecl,
    impslvsHdr.}
proc Slvs_MakeWorkplane*(h: Slvs_hEntity; group: Slvs_hGroup;
                         origin: Slvs_hEntity; normal: Slvs_hEntity): Slvs_Entity {.
    importc, cdecl, impslvsHdr.}
proc Slvs_MakeConstraint*(h: Slvs_hConstraint; group: Slvs_hGroup; `type`: cint;
                          wrkpl: Slvs_hEntity; valA: cdouble; ptA: Slvs_hEntity;
                          ptB: Slvs_hEntity; entityA: Slvs_hEntity;
                          entityB: Slvs_hEntity): Slvs_Constraint {.importc,
    cdecl, impslvsHdr.}
{.pop.}
