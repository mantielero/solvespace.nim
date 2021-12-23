import ../wrapper/slvs
import types,params, system

proc addPoint*[X,Y,Z:SomeNumber](sys:var System; x:X; y:Y; z:Z; group:IdGroup):Point3d =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId

  var xid = sys.addParam(x, grp )
  var yid = sys.addParam(y, grp )
  var zid = sys.addParam(z, grp )

  #result = sys.entityNewId.Point3d
  result.id = sys.entityNewId
  result.sys = sys
  sys.entities &= Slvs_MakePoint3d( result.IdEntity, grp.IdGroup, xid, yid, zid ) 
  sys.entityNewId += 1  

proc addPoint*[X,Y,Z:SomeNumber](sys:var System; x:X; y:Y; z:Z):Point3d =
  addPoint(sys, x, y, z, sys.currentGroup)


#[ proc xid*(sys:System; p:Point3d):IdParam =
  sys.getEntity(p).param[0]

proc yid*(sys:System; p:Point3d):IdParam =
  sys.getEntity(p).param[1]  

proc zid*(sys:System; p:Point3d):IdParam =
  sys.getEntity(p).param[2]

proc coord*(sys:System; p:Point3d):tuple[x,y,z:float] =
  let xid = sys.xid(p)
  let yid = sys.yid(p)  
  let zid = sys.zid(p)   
  (sys.params[xid-1].val, sys.params[yid-1].val, sys.params[zid-1].val) ]#



proc xid*(p:Point3d):IdParam =
  p.sys.getEntity(p.id).param[0]

proc yid*(p:Point3d):IdParam =
  p.sys.getEntity(p.id).param[1]  

proc zid*(p:Point3d):IdParam =
  p.sys.getEntity(p.id).param[2]

proc x*(p:Point3d):float =
  let xid = p.xid
  p.sys.params[xid-1].val

proc y*(p:Point3d):float =
  let yid = p.yid
  p.sys.params[yid-1].val

proc z*(p:Point3d):float =
  let zid = p.zid
  p.sys.params[zid-1].val

proc coord*(p:Point3d):tuple[x,y,z:float] =
  let xid = p.xid
  let yid = p.yid
  let zid = p.zid
  (p.sys.params[xid-1].val, p.sys.params[yid-1].val, p.sys.params[zid-1].val)

proc toPoint3d*(sys:System; id:IdEntity):Point3d =
  result.sys = sys
  result.id  = id