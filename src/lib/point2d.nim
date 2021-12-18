import ../wrapper/slvs
import types,params, system, constants

proc addPoint*[X,Y:SomeNumber](sys:var System; x:X; y:Y; workplane:Workplane = wpFree; group:IdGroup = 0):Point2d =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId

  var xid = sys.addParam(x, grp )
  var yid = sys.addParam(y, grp )

  result = sys.entityNewId.Point2d
  sys.entities &= Slvs_MakePoint2d( result.IdEntity, grp.IdGroup, workplane, xid, yid ) 
  sys.entityNewId += 1  
