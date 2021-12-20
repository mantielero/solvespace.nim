import ../wrapper/slvs
import types, constants

proc addDistance*(sys:var System; distance:SomeNumber; workplane:Workplane; group:IdGroup  ):Distance =
  let distanceId = sys.addParam(distance, group)
  result.id  = sys.entityNewId
  result.sys = sys
  sys.entities &= Slvs_MakeDistance( result.IdEntity, group.IdGroup, 
                                        workplane.IdEntity, 
                                        distanceId)
  sys.entityNewId += 1

proc addDistance*(sys:var System; distance:SomeNumber):Distance =
  addDistance(sys, distance, sys.currentWorkplane, sys.currentGroup)