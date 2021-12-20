import ../wrapper/slvs

type
  IdParam*      = Slvs_hParam
  IdEntity*     = Slvs_hEntity
  IdConstraint* = Slvs_hConstraint
  IdGroup*      = Slvs_hGroup

  System* = ref SystemObj
  SystemObj* = object
    sys*:Slvs_System
    params*:seq[Slvs_Param]
    entities*:seq[Slvs_Entity]
    constraints*:seq[Slvs_Constraint]
    paramNewId*:IdParam  ## Keeps track of the following identifier
    entityNewId*:IdEntity
    constraintNewId*:IdConstraint
    groupNewId*:IdGroup
    currentGroup*:IdGroup
    currentWorkplane*:Workplane


  #EntityObj = object
  #  id*:IdEntity
  #  sys*:System  

  ArcOfCircle* = object#distinct EntityObj
    id*:IdEntity
    sys*:System    
  Circle*      = object#distinct toIdEntity
    id*:IdEntity
    sys*:System  
  Distance*    = object #distinct IdEntity
    id*:IdEntity
    sys*:System  
  Normal3d*    = object #distinct IdEntity
    id*:IdEntity
    sys*:System    
  #Point2d*     = distinct IdEntity
  #Point3d*     = distinct IdEntity  
  Point2d*     = object
    id*:IdEntity
    sys*:System 
  Point3d*     = object
    id*:IdEntity
    sys*:System
  Segment*     = object
    id*:IdEntity
    sys*:System    
  #Segment*     = distinct IdEntity
  Workplane*   = object #distinct IdEntity
    id*:IdEntity
    sys*:System    

  Quaternion* = object
    id*:IdEntity
    sys*:System 
    #qw*, qx*, qy*, qz*: uint

  EntitiesTypes* = ArcOfCircle | Circle | Distance | Normal3d | Point2d  | Point3d | Quaternion | Segment | Workplane



converter toIdEntity*(val:EntitiesTypes):IdEntity =
  val.id.IdEntity


proc `$`*(p:Slvs_Param):string =
  return "Param: entity=" & $p.h & " group=" & $p.group & " val=" & $p.val 


proc `$`*(s:Slvs_System):string =
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

#proc `$`(segment:Segment):string =
