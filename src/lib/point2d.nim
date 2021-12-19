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

proc xid*(sys:System; p:Point2d):IdParam =
  sys.getEntity(p).param[0]

proc yid*(sys:System; p:Point2d):IdParam =
  sys.getEntity(p).param[1]  

proc coord*(sys:System; p:Point2d):tuple[x,y:float] =
  let xid = sys.xid(p)
  let yid = sys.yid(p)  
  (sys.params[xid-1].val, sys.params[yid-1].val)