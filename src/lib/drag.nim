#import ../wrapper/slvs
import types, point3d

proc drag*( sys:var System; p:Point3d) =
  sys.sys.dragged[0] = sys.xid(p)
  sys.sys.dragged[1] = sys.yid(p)
  sys.sys.dragged[2] = sys.zid(p)