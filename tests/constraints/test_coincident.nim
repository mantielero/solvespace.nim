import solvespace

proc main =
  var sys = newSystem()

  # Coincident points in 3D space
  block:
    sys.setGroup(1)
        
    let p1 = sys.addPoint(1.1, 2.2, 3.3)
    let p2 = sys.addPoint(4.4, 5.5, 6.6)

    coincident(p1,p2)
    let res = sys.solve
    assert res == rOK
    assert p1.x ~= p2.x
    assert p1.y ~= p2.y
    assert p1.z ~= p2.z    

  # Point coincident with workplane
  block:
    sys.setGroup(2)    
    # Lets create a XY workplane 10 units high
    let wp = sys.addWorkplane( 0, 0, 10, # Origin
                               1, 0, 0, # u
                               0, 1, 0) # v


    let p = sys.addPoint(1.1, 2.2, 3.3)

    coincident(p, wp)
    let res = sys.solve
    assert res == rOK
    assert p.x ~= 1.1
    assert p.y ~= 2.2
    assert p.z ~= 10   # The point gets moved to the workplane



  block:
    sys.setGroup(3)    

    let p1 = sys.addPoint(100, 0, 10)
    let p2 = sys.addPoint(100, 50, 10)
    let s  = sys.addSegment( p1, p2 )

    let p = sys.addPoint(31, 32, 33)

    coincident(p, s)
    let res = sys.solve
    assert res == rOK
    assert p.x ~= 100
    assert p.y ~= 32
    assert p.z ~= 10   # The point gets moved to the workplane