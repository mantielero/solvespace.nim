import strformat
import ../wrapper/slvs
import types, point3d, point2d, system, normal


proc showPoint(sys:System; pid:IdEntity):string =
  let entity = sys.entities[pid-1]
  if entity.`type` == SLVS_E_POINT_IN_3D:
    return &"Point3d: {sys.coord(entity.h.Point3d)}"
  elif entity.`type` == SLVS_E_POINT_IN_2D:
    return &"Point2d: {sys.coord(entity.h.Point2d)}" 
  echo entity

proc showEntities*(sys:System) =
  for i in sys.entities:
    echo &"Entity: {i.h}"
    echo &"   group: {i.group}   workplane: {i.wrkpl}"
    
    case i.`type`:
      of SLVS_E_POINT_IN_3D:
        echo "   Point3d: ", sys.coord(i.h.Point3d)
      of SLVS_E_POINT_IN_2D:
        echo "   Point2d: ", sys.coord(i.h.Point2d)
      of SLVS_E_DISTANCE:
        echo "   Distance: ", sys.getParam(i.param[0]).val
        echo "             ", i
      of SLVS_E_NORMAL_IN_3D:
        echo "   Normal3d: ", sys.getQuaternion(i.h.Normal3d)   
      of SLVS_E_WORKPLANE:
        echo "   Workplane: " 
        echo "     - Origin: ", sys.showPoint(i.point[0])
        echo "     - Normal: Quaternion: ", sys.getQuaternion(i.normal.Normal3d) 
      of SLVS_E_LINE_SEGMENT:
        echo "   Segment:"
        echo "     - from: ", sys.showPoint(i.point[0])
        echo "     - to:   ", sys.showPoint(i.point[1]) 
      of SLVS_E_ARC_OF_CIRCLE:
        echo "   ArcOfCircle:"
        echo "     - normal: ", sys.getQuaternion(i.normal.Normal3d) 
        echo "     - center: ", sys.showPoint(i.point[0])
        echo "     - from:   ", sys.showPoint(i.point[1])
        echo "     - to:     ", sys.showPoint(i.point[2])
      of SLVS_E_CIRCLE:
        echo "   Circle:"
        echo "     - normal: Quaternion: ", sys.getQuaternion(i.normal.Normal3d) 
        echo "     - center: ", sys.showPoint(i.point[0])
        #let distance = sys.getParam(sys.getEntity(i.distance)).val
        let distance = sys.getParam( sys.getEntity(i.distance).param[0] ).val
        echo "     - radius: ", distance       
      else:
        echo "    ", i

#[

  SLVS_E_NORMAL_IN_2D* = 60001

  SLVS_E_CUBIC* = 80002

]#