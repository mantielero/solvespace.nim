import ../wrapper/slvs
import types, constants

proc addDistance*(sys:var System; distance:SomeNumber; workplane:Workplane; group:IdGroup = 0 ):Distance =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId

  let distanceId = sys.addParam(distance, grp)
  result = sys.entityNewId.Distance
  sys.entities &= Slvs_MakeDistance( result.IdEntity, grp.IdGroup, 
                                        workplane.IdEntity, 
                                        distanceId)
  sys.entityNewId += 1

