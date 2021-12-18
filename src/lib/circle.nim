import ../wrapper/slvs
import types, constants

proc addCircle*( sys:var System; center:Point2d; normal:Normal3d; radius:SomeNumber; 
                 workplane:Workplane; group:IdGroup = 0 ):Circle =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId

  let distanceId = sys.addDistance(radius, workplane, grp)

  result = sys.entityNewId.Circle
  sys.entities &= Slvs_MakeCircle( result.IdEntity, grp.IdGroup, workplane.IdEntity, 
                                   center.IdEntity, normal.IdEntity, distanceId.IdEntity)
  sys.entityNewId += 1


#[
    sys.entity[sys.entities++] = Slvs_MakeCircle(402, g, 200,
                                    306, 102, 307);


proc Slvs_MakeCircle*(h: Slvs_hEntity; group: Slvs_hGroup; wrkpl: Slvs_hEntity;
                      center: Slvs_hEntity; normal: Slvs_hEntity;
                      radius: Slvs_hEntity): Slvs_Entity 
]#