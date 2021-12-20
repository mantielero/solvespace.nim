import ../wrapper/slvs
import types, constants

proc newSystem*():System =
  result = new System 
  result.paramNewId      = 1
  result.entityNewId     = 1
  result.constraintNewId = 1
  result.groupNewId      = 1
  result.sys.dragged[0]  = 0 
  result.sys.dragged[1]  = 0 
  result.sys.dragged[2]  = 0 
  result.sys.dragged[3]  = 0 
  result.currentGroup    = 0

  var wpFree:Workplane
  wpFree.id = SLVS_FREE_IN_3D
  wpFree.sys = result
  result.currentWorkplane = wpFree
  result.sys.calculateFaileds = 1 # By default, report which constraints caused the problem.


proc getParam*(sys:System, p:IdParam):Slvs_Param =
  sys.params[p - 1]

proc getEntity*(sys:System, e:IdEntity):Slvs_Entity =
  sys.entities[e - 1]

proc setGroup*(sys:var System; val:IdGroup) =
  sys.currentGroup = val

proc setWorkplane*(sys:var System; val:Workplane) =
  sys.currentWorkplane = val  

proc getDOF*(sys:var System):int =
  sys.sys.dof.int