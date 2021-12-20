import ../wrapper/slvs
import types, system

proc addWorkplane*[OX,OY,OZ, UX,UY,UZ,VX,VY,VZ:SomeNumber]( sys:var System;  ox:OX; oy:OY; oz:OZ;
                   ux:UX; uy:UY; uz:UZ; vx:VX;vy:VY;vz:VZ; group:IdGroup  ):Workplane =
  let origin = sys.addPoint(ox, oy, oz, group )
  let normal = sys.addNormal( ux, uy, uz, 
                              vx, vy, vz, group )  
  result.id  = sys.entityNewId
  result.sys = sys
  sys.entities &= Slvs_MakeWorkplane(result.IdEntity, group, origin.IdEntity, normal)
  sys.entityNewId += 1

proc addWorkplane*[OX,OY,OZ, UX,UY,UZ,VX,VY,VZ:SomeNumber]( sys:var System;  ox:OX; oy:OY; oz:OZ;
                   ux:UX; uy:UY; uz:UZ; vx:VX;vy:VY;vz:VZ):Workplane =
  if sys.currentGroup == 0:
    raise newException(ValueError, "you need to `setGroup` for the system before using this function")
  addWorkplane( sys, ox, oy, oz, ux, uy, uz, vx, vy, vz, sys.currentGroup )

proc getNormal*(wp:Workplane):Normal3d =
  result.sys = wp.sys
  result.id  = wp.sys.getEntity(wp).normal

proc getOrigin*(wp:Workplane):Point3d =
  #sys.getEntity(wp).point[0].Point3d
  result.sys = wp.sys
  result.id = wp.sys.getEntity(wp).point[0]