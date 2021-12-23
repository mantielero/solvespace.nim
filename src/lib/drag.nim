#import ../wrapper/slvs
import types, point3d, point2d

proc drag*( p:Point3d) =
  p.sys.sys.dragged[0] = p.xid
  p.sys.sys.dragged[1] = p.yid
  p.sys.sys.dragged[2] = p.zid

proc drag*( p:Point2d) =
  p.sys.sys.dragged[0] = p.xid
  p.sys.sys.dragged[1] = p.yid


proc drag*( p1,p2:Point2d) =
  p1.sys.sys.dragged[0] = p1.xid
  p1.sys.sys.dragged[1] = p1.yid
  p1.sys.sys.dragged[2] = p2.xid
  p1.sys.sys.dragged[3] = p2.yid