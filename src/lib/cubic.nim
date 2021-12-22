import ../wrapper/slvs
import types,params, system, constants

proc addCubic*[P:Point2d | Point3d](sys:var System; p1,p2,p3,p4:P):Cubic =
  #var sys = p1.sys
  result.id = sys.entityNewId
  result.sys = sys
  sys.entities &= Slvs_Entity Slvs_MakeCubic( result.IdEntity, sys.currentGroup, sys.currentWorkplane,
        p1.id, p2.id, p3.id, p4.id )
  sys.entityNewId += 1  