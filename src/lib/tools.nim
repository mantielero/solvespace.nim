import math
import ../wrapper/slvs
import types, point3d, point2d, segment#, workplane

proc `~=`*[T:SomeFloat](val1,val2:T):bool =
  almostEqual(val1, val2) #, 5)

proc measureDistance*(p1,p2:Point3d):float =
  sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2 + (p1.z - p2.z)^2) 

proc measureDistance*(p1,p2:Point2d):float =
  sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)



proc vector*(p1,p2:Point3d):tuple[x,y,z:float] =
  (p2.x-p1.x, p2.y-p1.y, p2.z-p1.z)

proc vector*(p1,p2:Point2d):tuple[x,y:float] =
  (p2.x-p1.x, p2.y-p1.y)

# Dot product
proc dotProduct*(v1,v2:tuple[x,y,z:SomeFloat]):float =
  v1[0]*v2[0] + v1[1]*v2[1] + v1[2]*v2[2]

proc dotProduct*(v1,v2:tuple[x,y:SomeFloat]):float =
  v1[0]*v2[0] + v1[1]*v2[1]

proc `*`*[T:tuple[x,y:SomeFloat] | tuple[x,y,z:SomeFloat]](v1, v2:T):float =
  dotProduct(v1,v2)

# Cross product
proc crossProduct*(v1,v2:tuple[x,y,z:SomeFloat]):tuple[x,y,z:float] =
  let (x1,y1,z1) = (v1[0], v1[1], v1[2])
  let (x2,y2,z2) = (v2[0], v2[1], v2[2])
  ( y1*z2 - z1*y2,
    z1*x2 - x1*z2,
    x1*y2 - x2*y1)

proc crossProduct*(v1,v2:tuple[x,y:SomeFloat]):float =
  ## in 2d we just get the scalar; the vector would be perpendicular to the working plane
  let x1,y1 = (v1[0], v1[1])
  let x2,y2 = (v2[0], v2[1])
  x1*y2 - y1*x2


proc `^`*(v1, v2:tuple[x,y,z:SomeFloat]):tuple[x,y,z:float] =
  crossProduct(v1,v2)

proc `^`*(v1, v2:tuple[x,y:SomeFloat]):float =
  crossProduct(v1,v2)

# Module
proc module*(v:tuple[x,y,z:SomeNumber]):float =
  sqrt( v[0]^2 + v[1]^2 + v[2]^2 )

# Distance between point and line
proc measureDistance*(point:Point3d; line:Segment):float =
  ##[ if A and B define the segment, this is the result of the modulus
  of the cross product: `AB ^ AP` divided by the modulus of `AB`.
  ]##
  let points = getPoints(line)

  if points[0][1] == SLVS_E_POINT_IN_3D and points[1][1] == SLVS_E_POINT_IN_3D :  # Point3d case
    var p1,p2:Point3d
    p1.id = points[0][0]
    p1.sys = line.sys
    p2.id = points[1][0]
    p2.sys = line.sys    


    let p1p2 = vector(p1, p2)
    let p1p3 = vector(p1, point)

    let cp = crossProduct(p1p2, p1p3)
    return cp.module / measureDistance(p1,p2)
  else:
    raise newException(ValueError, "mixing Point3d with 2d segment")

proc measureDistance*(point:Point2d; line:Segment):float =
  ##[ if A and B define the segment, this is the result of the modulus
  of the cross product: `AB ^ AP` divided by the modulus of `AB`.
  ]##
  let points = getPoints(line)
  if points[0][1] == SLVS_E_POINT_IN_2D and points[1][1] == SLVS_E_POINT_IN_2D:  # Point2d case
    var p1,p2:Point2d
    p1.id = points[0][0]
    p1.sys = line.sys
    p2.id = points[1][0]
    p2.sys = line.sys
    let p1p2 = vector(p1, p2)
    let p1p3 = vector(p1, point)

    let cp = crossProduct(p1p2, p1p3)
    return cp / measureDistance(p1,p2)
  else:
    raise newException(ValueError, "mixing Point2d with 3d segment")
  

