import ../wrapper/slvs
import types, constants

proc addCircle*( sys:var System; center:Point2d; normal:Normal3d; radius:SomeNumber; 
                 workplane:Workplane; group:IdGroup):Circle =
  let distanceId = sys.addDistance(radius, workplane, group)

  result = sys.entityNewId.Circle
  sys.entities &= Slvs_MakeCircle( result.IdEntity, group.IdGroup, workplane.IdEntity, 
                                   center.IdEntity, normal.IdEntity, distanceId.IdEntity)
  sys.entityNewId += 1


proc addCircle*( sys:var System; center:Point2d; normal:Normal3d; radius:SomeNumber):Circle =
  addCircle( sys, center, normal, radius, sys.currentWorkplane, sys.currentGroup)
  

#[
    sys.entity[sys.entities++] = Slvs_MakeCircle(402, g, 200,
                                    306, 102, 307);


proc Slvs_MakeCircle*(h: Slvs_hEntity; group: Slvs_hGroup; wrkpl: Slvs_hEntity;
                      center: Slvs_hEntity; normal: Slvs_hEntity;
                      radius: Slvs_hEntity): Slvs_Entity 
]#