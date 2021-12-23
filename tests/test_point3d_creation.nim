discard """
  output: '''
'''
"""
import solvespace

proc main =
  var sys = newSystem()
  
  sys.setGroup( 1 )     # This will contain a single group, which will arbitrarily number 1.
  let p1 = sys.addPoint(11,12.5,-3)   # A point, initially at (x y z) = (10 10 10)


  # Params properly created
  block:
    assert sys.params.len == 3  
    for i,param in sys.params:
        assert param.h.int == i + 1
        assert param.group  == 1
    assert sys.params[0].val == 11.0
    assert sys.params[1].val == 12.5
    assert sys.params[2].val  == -3.0 

  # Entity properly created
  block:
    assert sys.entities.len == 1
    var e = sys.entities[0]
    assert e.h.int == 1
    assert e.group == 1
    assert e.`type` == SLVS_E_POINT_IN_3D
    assert e.wrkpl == wpFree  # Default
    for i in 0..3: assert e.point[i] == 0
    assert e.normal == 0
    assert e.distance == 0
    assert e.param[0] == 1
    assert e.param[1] == 2
    assert e.param[2] == 3
    assert e.param[3] == 0

  

main()
