import math
import types, point3d

proc `~=`*[T:SomeFloat](val1,val2:T):bool =
  almostEqual(val1, val2)

proc measureDistance*(p1,p2:Point3d):float =
  sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2 + (p1.z - p2.z)^2) 