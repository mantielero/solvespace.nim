import ../wrapper/slvs
import types, system

proc newNormal*(sys:var System; qw, qx, qy, qz:Slvs_hParam; group:IdGroup ):Normal3d  = #:Segment 
  result.sys = sys
  result.id  = sys.entityNewId
  sys.entities &= Slvs_MakeNormal3d( result.IdEntity, group, 
                              qw.Slvs_hParam, qx.Slvs_hParam, qy.Slvs_hParam, qz.Slvs_hParam)
  sys.entityNewId += 1


proc addNormal*[UX,UY,UZ,VX,VY,VZ:SomeNumber](sys:var System; 
       ux:UX; uy:UY; uz:UZ; 
       vx:VX;vy:VY;vz:VZ; group:IdGroup ):Normal3d = #:Segment
  var qIds = sys.addQuaternion( ux, uy, uz, vx, vy, vz, group)

  result = newNormal(sys, group, qIds[0], qIds[1], qIds[2], qIds[3])

proc toNormal3d*(sys:System; id:IdEntity):Normal3d =
  result.sys = sys
  result.id = id


proc qwid*(sys:System; n:Normal3d):IdParam =
  sys.getEntity(n).param[0]

proc qxid*(sys:System; n:Normal3d):IdParam =
  sys.getEntity(n).param[1]

proc qyid*(sys:System; n:Normal3d):IdParam =
  sys.getEntity(n).param[2]

proc qzid*(sys:System; n:Normal3d):IdParam =
  sys.getEntity(n).param[3]

proc getQuaternion*(sys:System; n:Normal3d):tuple[qw,qx,qy,qz:float] =
  let qwid = sys.qwid(n)
  let qxid = sys.qxid(n)
  let qyid = sys.qyid(n)  
  let qzid = sys.qzid(n)   
  (sys.params[qwid-1].val,sys.params[qxid-1].val, sys.params[qyid-1].val, sys.params[qzid-1].val)





proc qwid*(n:Normal3d):IdParam =
  n.sys.getEntity(n.id).param[0]

proc qxid*(n:Normal3d):IdParam =
  n.sys.getEntity(n.id).param[1]

proc qyid*(n:Normal3d):IdParam =
  n.sys.getEntity(n.id).param[2]

proc qzid*(n:Normal3d):IdParam =
  n.sys.getEntity(n.id).param[3]

proc getQuaternion*(n:Normal3d):tuple[qw,qx,qy,qz:float] =
  let qwid = n.qwid
  let qxid = n.qxid
  let qyid = n.qyid  
  let qzid = n.qzid  
  (n.sys.params[qwid-1].val, n.sys.params[qxid-1].val, n.sys.params[qyid-1].val, n.sys.params[qzid-1].val)