import ../wrapper/slvs
import types, system, tools 


proc newQuaternion*[N:SomeNumber; M:SomeNumber](u:tuple[x,y,z:N]; v:tuple[x,y,z:M]):tuple[qw,qx,qy,qz:float] =
  var qw,qx,qy,qz:cdouble
  Slvs_MakeQuaternion(u.x.cdouble, u.y.cdouble, u.z.cdouble,
                      v.x.cdouble, v.y.cdouble, v.z.cdouble,
                      cast[ptr cdouble](qw.unsafeAddr),
                      cast[ptr cdouble](qx.unsafeAddr),
                      cast[ptr cdouble](qy.unsafeAddr),
                      cast[ptr cdouble](qz.unsafeAddr) )
  return (qw.float, qx.float,qy.float, qz.float)


proc getU*(q:tuple[qw,qx,qy,qz:float]):tuple[x,y,z:float] =
  var x,y,z:cdouble
  let (qw,qx,qy,qz) = q
  Slvs_QuaternionU( qw.cdouble, qx.cdouble, qy.cdouble, qz.cdouble,
                    cast[ptr cdouble](x.unsafeAddr),
                    cast[ptr cdouble](y.unsafeAddr),
                    cast[ptr cdouble](z.unsafeAddr) )
  return (x.float, y.float, z.float)

proc getV*(q:tuple[qw,qx,qy,qz:float] ):tuple[x,y,z:float] =
  var x,y,z:cdouble
  let (qw,qx,qy,qz) = q
  Slvs_QuaternionV( qw.cdouble, qx.cdouble, qy.cdouble, qz.cdouble,
                    cast[ptr cdouble](x.unsafeAddr),
                    cast[ptr cdouble](y.unsafeAddr),
                    cast[ptr cdouble](z.unsafeAddr) )
  return (x.float, y.float, z.float)

proc getN*(q:tuple[qw,qx,qy,qz:float] ):tuple[x,y,z:float] =
  var x,y,z:cdouble
  let (qw,qx,qy,qz) = q
  Slvs_QuaternionN( qw.cdouble, qx.cdouble, qy.cdouble, qz.cdouble,
                    cast[ptr cdouble](x.unsafeAddr),
                    cast[ptr cdouble](y.unsafeAddr),
                    cast[ptr cdouble](z.unsafeAddr) )
  return (x.float, y.float, z.float)

proc base*(q:tuple[qw,qx,qy,qz:float] ):tuple[u,v,w:tuple[x,y,z:float]] =
  return (getU(q), getV(q), getN(q))


proc normal*(q:tuple[qw,qx,qy,qz:float]):tuple[x,y,z:float] =
  var n = getN(q)
  var m = n.module
  (n[0]/m, n[1]/m, n[2]/m)

#--------------------------------------------------

proc addQuaternion*[UX,UY,UZ,VX,VY,VZ:SomeNumber](sys:var System; 
       ux:UX; uy:UY; uz:UZ; 
       vx:VX;vy:VY;vz:VZ ):tuple[qw,qx,qy,qz:IdParam] {.discardable.} = 
  ##[
  Similarly, compute a unit quaternion in terms of two basis vectors.  
  ]##
  var (qw, qx, qy, qz) = newQuaternion( (ux.float, uy.float, uz.float), 
                                        (vx.float, vy.float, vz.float) )
  var p1 = sys.addParam(qw, sys.currentGroup )
  var p2 = sys.addParam(qx, sys.currentGroup )
  var p3 = sys.addParam(qy, sys.currentGroup )
  var p4 = sys.addParam(qz, sys.currentGroup )
  return (p1, p2, p3, p4)

proc toFloat(sys:System; q:tuple[qw,qx,qy,qz:IdParam]):tuple[qw,qx,qy,qz:float] = 
  result = ( sys.getParam(q[0]).val,
             sys.getParam(q[1]).val,
             sys.getParam(q[2]).val,
             sys.getParam(q[3]).val ) 

proc getU*(sys:System; q:tuple[qw,qx,qy,qz:IdParam]):tuple[x,y,z:float] =
  let qval = sys.toFloat(q)
  getU(qval)

proc getV*(sys:System; q:tuple[qw,qx,qy,qz:IdParam]):tuple[x,y,z:float] =
  let qval = sys.toFloat(q)
  getV(qval)

proc getN*(sys:System; q:tuple[qw,qx,qy,qz:IdParam]):tuple[x,y,z:float] =
  let qval = sys.toFloat(q)
  getN(qval)

proc base*(sys:System; q:tuple[qw,qx,qy,qz:IdParam]):tuple[u,v,w:tuple[x,y,z:float]] =
  (getU(sys,q), getV(sys,q), getN(sys,q))


proc normal*(sys:System; q:tuple[qw,qx,qy,qz:IdParam]):tuple[x,y,z:float] =
  let qval = sys.toFloat(q)
  normal(qval)
