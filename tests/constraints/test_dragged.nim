import solvespace

proc main =
  var sys = newSystem()

  # Fixing a point  
  block:
    sys.setGroup(1)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10, 10)
    let p2 = sys.addPoint(20, 20, 20)
    let s1 = sys.addSegment(p1, p2) 
    s1.length(100)

    p2.dragged

    let res = sys.solve

    assert res == rOK 
    assert p2.x ~= 20.0
    assert p2.y ~= 20.0    
    assert p2.z ~= 20.0    
