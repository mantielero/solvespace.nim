#[ discard """
output: '''
'''

""" ]#
import solvespace, math

proc main =
  var sys = newSystem()

  # Fixing distance between two points
  block:
    sys.setGroup(1)

    # Points
    let p1 = sys.addPoint(200, 200, 200)
    let p2 = sys.addPoint(200, 200, 300)

    distance(p1,p2, 200)

    let res = sys.solve
    assert res == rOK 
    assert measureDistance(p1, p2) ~= 200

  # Segment length
  block:
    sys.setGroup(2)

    # Points
    let p1 = sys.addPoint(200, 200, 200)
    let p2 = sys.addPoint(200, 200, 300)
    let s  = sys.addSegment(p1,p2)
    s.length( 200)

    let res = sys.solve
    assert res == rOK 
    assert measureDistance(p1, p2) ~= 200    

  # Distance between point and segment in 3D
  block:
    sys.setGroup(3)

    # Points
    let p1 = sys.addPoint(200, 200, 200)
    let p2 = sys.addPoint(200, 200, 0)
    p1.dragged # Fix the segment
    p2.dragged # Fix the segment
    let s  = sys.addSegment(p1,p2)
    #s.length( 200)
    #s.vertical

    let p3 = sys.addPoint(0, 200, 0)
    distance(p3, s, 400)

    let res = sys.solve
    assert res == rOK 
    assert ((200.0-p3.x)^2 + (200.0 - p3.y)^2)  ~= 400.0^2

  # Distance between point and workplane
#[   block:
    sys.setGroup(4)
    let wp = sys.addWorkplane( 0, 0, 100, # Origin
                               1, 0, 0, # u
                               0, 1, 0) # v

    # Points
    let p = sys.addPoint(200, 200, 200)

    distance(p, wp, 400)

    p.sys.sys.dragged[0] = p.xid
    p.sys.sys.dragged[1] = p.yid    
    #echo wp.origin.coord
    let res = sys.solve
    echo sys.getDOF
    if res != rOK:
      echo "Issue: res=", res
    echo res
    assert res == rOK  ]#

main()