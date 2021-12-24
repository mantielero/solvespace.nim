import solvespace

proc main =
  var q = newQuaternion( (1, 0, 0),
                         (0, 1, 0) )
  assert q == (1.0,0.0,0.0,0.0)
  var b = base(q)
  assert b[0] == (1.0,0.0,0.0)
  assert b[1] == (0.0,1.0,0.0)
  assert b[2] == (0.0,0.0,1.0)  

  var sys = newSystem()

  # Segments of equal lengths
  block:
    sys.setGroup(1)
    var qIds = sys.addQuaternion( 1, 0, 0, 
                                  0, 1, 0)
    assert qIds == (1.IdParam, 2.IdParam, 3.IdParam, 4.IdParam)
    var b = sys.base(qIds)
    assert b[0] == (1.0,0.0,0.0)
    assert b[1] == (0.0,1.0,0.0)
    assert b[2] == (0.0,0.0,1.0)      
    #assert res == rOK

main()