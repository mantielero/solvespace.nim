import ../wrapper/slvs
import types, constants, system

proc addSegment*[T:Point3d | Point2d](sys:var System; p1,p2:T; workplane:Workplane; group:IdGroup = 0 ):Segment =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId
  result = sys.entityNewId.Segment
  sys.entities &= Slvs_MakeLineSegment( result.IdEntity, grp.IdGroup, 
                                        workplane.IdEntity, 
                                        p1.IdEntity, p2.IdEntity )
  sys.entityNewId += 1



proc getPoints*(sys:System; s:Segment):seq[tuple[id:IdEntity; typ:uint]] =
  let segment = sys.getEntity(s)
  let pid1 = segment.point[0]
  let pid2 = segment.point[1]
  let typ1 = sys.getEntity(segment.point[0]).`type`.uint
  let typ2 = sys.getEntity(segment.point[1]).`type`.uint
  return @[(pid1, typ1), (pid2, typ2)]