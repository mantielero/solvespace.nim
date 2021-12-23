import ../wrapper/slvs
import types, constants, system

proc addCircle*[P:Point3d | Point2d]( sys:var System; center:P; normal:Normal3d; radius:SomeNumber; 
                 workplane:Workplane; group:IdGroup):Circle =
  let distanceId = sys.addDistance(radius, workplane, group)

  result.id  = sys.entityNewId
  result.sys = sys
  sys.entities &= Slvs_MakeCircle( result.IdEntity, group.IdGroup, workplane.IdEntity, 
                                   center.IdEntity, normal.IdEntity, distanceId.IdEntity)
  sys.entityNewId += 1


proc addCircle*[P:Point3d | Point2d]( sys:var System; center:P; normal:Normal3d; radius:SomeNumber):Circle =
  let distanceId = sys.addDistance( radius )
  result.id  = sys.entityNewId
  result.sys = sys
  sys.entities &= Slvs_MakeCircle( result.IdEntity, sys.currentGroup, sys.currentWorkplane, 
                                   center.IdEntity, normal.IdEntity, distanceId.IdEntity)
  sys.entityNewId += 1


proc radius*(c:Circle):float =
  let idDistance = c.sys.getEntity(c.id).distance
  let idParam = c.sys.getEntity(idDistance).param[0]
  c.sys.getParam(idParam).val