import ../wrapper/slvs
import types

proc newNormal*(sys:var System; qw, qx, qy, qz:Slvs_hParam; group:IdGroup ):Normal3d  = #:Segment 
  var grp = group
  if grp == 0:
    grp = sys.groupNewId
  result = sys.entityNewId.Normal3d
  sys.entities &= Slvs_MakeNormal3d( result.IdEntity, group, 
                              qw.Slvs_hParam, qx.Slvs_hParam, qy.Slvs_hParam, qz.Slvs_hParam)
  sys.entityNewId += 1


proc addNormal*[UX,UY,UZ,VX,VY,VZ:SomeNumber](sys:var System; 
       ux:UX; uy:UY; uz:UZ; 
       vx:VX;vy:VY;vz:VZ; group:IdGroup ):Normal3d = #:Segment
  var qIds = sys.addQuaternion( ux, uy, uz, vx, vy, vz, group)

  result = newNormal(sys, group, qIds[0], qIds[1], qIds[2], qIds[3])