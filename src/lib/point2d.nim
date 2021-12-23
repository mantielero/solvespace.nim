import ../wrapper/slvs
import types,params, system, constants

proc addPoint*[X,Y:SomeNumber](sys:var System; x:X; y:Y; workplane:Workplane; group:IdGroup):Point2d =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId

  var xid = sys.addParam(x, grp )
  var yid = sys.addParam(y, grp )

  result.id = sys.entityNewId
  result.sys = sys
  sys.entities &= Slvs_MakePoint2d( result.IdEntity, grp.IdGroup, workplane, xid, yid ) 
  sys.entityNewId += 1  

proc addPoint*[X,Y:SomeNumber](sys:var System; x:X; y:Y):Point2d =
  addPoint(sys, x, y, sys.currentWorkplane, sys.currentGroup)

#[ 
proc xid*(sys:System; p:Point2d):IdParam =
  sys.getEntity(p).param[0]

proc yid*(sys:System; p:Point2d):IdParam =
  sys.getEntity(p).param[1]  


proc coord*(sys:System; p:Point2d):tuple[x,y:float] =
  let xid = sys.xid(p)
  let yid = sys.yid(p)  
  (sys.params[xid-1].val, sys.params[yid-1].val) ]#





proc xid*(p:Point2d):IdParam =
  p.sys.getEntity(p.id).param[0]

proc yid*(p:Point2d):IdParam =
  p.sys.getEntity(p.id).param[1]  

proc coord*(p:Point2d):tuple[x,y:float] =
  let xid = p.xid
  let yid = p.yid
  (p.sys.params[xid-1].val, p.sys.params[yid-1].val)

proc x*(p:Point2d):float =
  let xid = p.xid
  p.sys.params[xid-1].val

proc y*(p:Point2d):float =
  let yid = p.yid
  p.sys.params[yid-1].val

proc toPoint2d*(sys:System; id:IdEntity):Point2d =
  result.sys = sys
  result.id  = id