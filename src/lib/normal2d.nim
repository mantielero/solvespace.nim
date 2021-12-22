import ../wrapper/slvs
import types, system

proc addNormal*(sys:var System; wrkpl:Workplane; group:IdGroup ):Normal2d  = #:Segment 
  result.sys = sys
  result.id  = sys.entityNewId
  #Slvs_MakeNormal2d(Slvs_hEntity h, Slvs_hGroup group,
  #                                          Slvs_hEntity wrkpl)
  sys.entities &= Slvs_MakeNormal2d( result.IdEntity, group, wrkpl)
  sys.entityNewId += 1




#[ 
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
  (sys.params[qwid-1].val,sys.params[qxid-1].val, sys.params[qyid-1].val, sys.params[qzid-1].val) ]#





#[ proc qwid*(n:Normal3d):IdParam =
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
  (n.sys.params[qwid-1].val, n.sys.params[qxid-1].val, n.sys.params[qyid-1].val, n.sys.params[qzid-1].val) ]#