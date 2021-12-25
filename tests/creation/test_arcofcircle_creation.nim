discard """
  output: '''
'''
"""
import solvespace, math

proc main =
  var sys = newSystem()
  
  sys.setGroup( 1 )     # This will contain a single group, which will arbitrarily number 1.

  # Arc of circle
  let normal = sys.addNormal( 1, 0, 0,
                              0, 1, 0 ) 
  let pCenter = sys.addPoint(0, 0, 300)
  let pStart  = sys.addPoint(-100, 0, 300)
  let pFinish = sys.addPoint(100, 0, 300)
  let aoc = sys.addArcOfCircle(normal, pCenter, pStart, pFinish)


  # Params properly created
#[   block:
    assert sys.params.len == 2 
    for i,param in sys.params:
        assert param.h.int == i + 1
        assert param.group  == 1
    assert sys.params[0].val == 11.0
    assert sys.params[1].val == 12.5 ]#


  # Entity properly created
#[   block:
    assert sys.entities.len == 1
    var e = sys.entities[0]
    assert e.h.int == 1
    assert e.group == 1
    assert e.`type` == SLVS_E_POINT_IN_2D
    assert e.wrkpl == wpFree  # Default
    for i in 0..3: assert e.point[i] == 0
    assert e.normal == 0
    assert e.distance == 0
    assert e.param[0] == 1
    assert e.param[1] == 2
    assert e.param[2] == 0
    assert e.param[3] == 0 ]#

  # Functions
#[   block:
    assert p1.xid == 1
    assert p1.yid == 2


    assert p1.x == 11.0
    assert p1.y == 12.5

    assert p1.coord == (11.0, 12.5)
    assert sys.toPoint2d(1) == p1  ]#
  block:
    assert aoc.radius ~= 100.0
    assert aoc.length ~= PI * aoc.radius

main()
