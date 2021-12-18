import ../wrapper/slvs
import types, system

proc addWorkplane*[OX,OY,OZ, UX,UY,UZ,VX,VY,VZ:SomeNumber]( sys:var System;  ox:OX; oy:OY; oz:OZ;
                   ux:UX; uy:UY; uz:UZ; vx:VX;vy:VY;vz:VZ; group:IdGroup = 0 ):Workplane =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId
  let origin = sys.addPoint(ox, oy, oz, grp )
  let normal = sys.addNormal( ux, uy, uz, 
                              vx, vy, vz, grp )  
  result = sys.entityNewId.Workplane
  sys.entities &= Slvs_MakeWorkplane(result.IdEntity, grp, origin.IdEntity, normal)
  sys.entityNewId += 1


proc getNormal*(sys:System; wp:Workplane):Normal3d =
  sys.getEntity(wp).normal.Normal3d

proc getOrigin*(sys:System; wp:Workplane):Point3d =
  sys.getEntity(wp).point[0].Point3d