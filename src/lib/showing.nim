import strformat
import ../wrapper/slvs
import types, point3d, point2d, system, normal3d, normal2d


proc showPoint(sys:System; pid:IdEntity):string =
  let entity = sys.entities[pid-1]
  if entity.`type` == SLVS_E_POINT_IN_3D:
    #return &"Point3d: {sys.coord(entity.h.Point3d)}"
    var p = toPoint3d(sys, entity.h)
    return &"Point3d: {p.coord}"       #id #{entity.h.}"
  elif entity.`type` == SLVS_E_POINT_IN_2D:
    var p = toPoint2d(sys, entity.h)
    return &"Point2d: {p.coord}" 
  echo entity

proc showEntities*(sys:System) =
  for i in sys.entities:
    echo &"Entity: {i.h}"
    echo &"   group: {i.group}   workplane: {i.wrkpl}"
    
    case i.`type`:
      of SLVS_E_POINT_IN_3D:
        var p = toPoint3d(sys, i.h)
        echo "   Point3d: ", p.coord #sys.coord(i.h.Point3d)
      of SLVS_E_POINT_IN_2D:
        var p = toPoint2d(sys, i.h)
        echo "   Point2d: ", p.coord#sys.coord(i.h.Point2d)
      of SLVS_E_DISTANCE:
        echo "   Distance: ", sys.getParam(i.param[0]).val
      of SLVS_E_NORMAL_IN_3D:
        let n = toNormal3d(sys, i.h)
        echo "   Normal3d: Quaternion: ", n.getQuaternion #sys.getQuaternion(i.h.Normal3d)   
      of SLVS_E_WORKPLANE:
        let n = toNormal3d(sys, i.normal)
        echo "   Workplane: " 
        echo "     - Origin: ", sys.showPoint(i.point[0])
        echo "     - Normal: Quaternion: ", n.getQuaternion #sys.getQuaternion(i.normal.Normal3d) 
      of SLVS_E_LINE_SEGMENT:
        echo "   Segment:"
        echo "     - from: ", sys.showPoint(i.point[0])
        echo "     - to:   ", sys.showPoint(i.point[1]) 
      of SLVS_E_ARC_OF_CIRCLE:
        let n = toNormal3d(sys, i.normal)
        echo "   ArcOfCircle:"
        echo "     - normal: Quaternion: ", n.getQuaternion 
        echo "     - center: ", sys.showPoint(i.point[0])
        echo "     - from:   ", sys.showPoint(i.point[1])
        echo "     - to:     ", sys.showPoint(i.point[2])
      of SLVS_E_CIRCLE:
        let n = toNormal3d(sys, i.normal)
        echo "   Circle:"
        echo "     - normal: Quaternion: ", n.getQuaternion
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