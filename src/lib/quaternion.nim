import ../wrapper/slvs
import types#, constants


proc newQuaternion*[N:SomeNumber; M:SomeNumber](u:tuple[x,y,z:N]; v:tuple[x,y,z:M]):tuple[qw,qx,qy,qz:float] =
  var qw,qx,qy,qz:cdouble
  Slvs_MakeQuaternion(u.x.cdouble, u.y.cdouble, u.z.cdouble,
                      v.x.cdouble, v.y.cdouble, v.z.cdouble,
                      cast[ptr cdouble](qw.unsafeAddr),
                      cast[ptr cdouble](qx.unsafeAddr),
                      cast[ptr cdouble](qy.unsafeAddr),
                      cast[ptr cdouble](qz.unsafeAddr) )
  return (qw.float, qx.float,qy.float, qz.float)


proc addQuaternion*[UX,UY,UZ,VX,VY,VZ:SomeNumber](sys:var System; 
       ux:UX; uy:UY; uz:UZ; 
       vx:VX;vy:VY;vz:VZ; group:IdGroup ):tuple[qw,qx,qy,qz:IdParam] {.discardable.} =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId       
  var (qw, qx, qy, qz) = newQuaternion( (ux.float, uy.float, uz.float), 
                         (vx.float, vy.float, vz.float))
  var p1 = sys.addParam(qw, grp)
  var p2 = sys.addParam(qx, grp)
  var p3 = sys.addParam(qy, grp)
  var p4 = sys.addParam(qz, grp)    
  return (p1, p2, p3, p4)