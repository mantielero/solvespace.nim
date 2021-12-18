import ../wrapper/slvs
import types,params, system

proc addPoint*[X,Y,Z:SomeNumber](sys:var System; x:X; y:Y; z:Z; group:IdGroup = 0):Point3d =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId

  var xid = sys.addParam(x, grp )
  var yid = sys.addParam(y, grp )
  var zid = sys.addParam(z, grp )

  result = sys.entityNewId.Point3d
  sys.entities &= Slvs_MakePoint3d( result.IdEntity, grp.IdGroup, xid, yid, zid ) 
  sys.entityNewId += 1  


proc xid*(sys:var System, p:Point3d):IdParam =
  sys.getEntity(p).param[0]

proc yid*(sys:var System, p:Point3d):IdParam =
  sys.getEntity(p).param[1]  

proc zid*(sys:var System, p:Point3d):IdParam =
  sys.getEntity(p).param[2]  