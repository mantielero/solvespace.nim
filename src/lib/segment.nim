import ../wrapper/slvs
import types, constants, system

proc addSegment*[T:Point3d | Point2d](sys:var System; p1,p2:T; workplane:Workplane; group:IdGroup ):Segment =
  result.sys = sys
  result.id = sys.entityNewId
  sys.entities &= Slvs_MakeLineSegment( result.IdEntity, group.IdGroup, 
                                        workplane.IdEntity, 
                                        p1.IdEntity, p2.IdEntity )
  sys.entityNewId += 1

proc addSegment*[T:Point3d | Point2d](sys:var System; p1,p2:T ):Segment =
  addSegment(sys, p1 , p2, sys.currentWorkplane, sys.currentGroup)

proc getPoints*(s:Segment):seq[tuple[id:IdEntity; typ:uint]] =
  let segment = s.sys.getEntity(s)
  let pid1 = segment.point[0]
  let pid2 = segment.point[1]
  let typ1 = s.sys.getEntity(segment.point[0]).`type`.uint
  let typ2 = s.sys.getEntity(segment.point[1]).`type`.uint
  return @[(pid1, typ1), (pid2, typ2)]