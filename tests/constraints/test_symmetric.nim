import solvespace

proc main =
  var sys = newSystem()

  # Two points symmetric regarding a workplane
  block:
    sys.setGroup(1)
    let wp = sys.addWorkplane( 0, 0, 100, # Origin
                               1, 0, 0, # u
                               0, 1, 0) # v

    let p1 = sys.addPoint(200, 200, 200)
    let p2 = sys.addPoint(200, 200, 300)

    symmetric(p1, p2, wp)  

    let res = sys.solve
    assert res == rOK

    assert measureDistance(p1, wp) + measureDistance(p2, wp) < 0.0001

  # Symmetric horizontally
  block:
    sys.setGroup(2)
    let wp = sys.addWorkplane( 0, 0, 100, # Origin
                               1, 0, 0, # u
                               0, 1, 0) # v
    sys.setWorkplane(wp)
    let p1 = sys.addPoint(10, 10)
    let p2 = sys.addPoint(20, 20)

    symmetricHorizontal(p1, p2)
    let res = sys.solve
    assert res == rOK

    assert p1.x ~= -p2.x
    assert p1.y ~= p2.y       

  # Symmetric vertically
  block:
    sys.setGroup(3)
    let wp = sys.addWorkplane( 0, 0, 100, # Origin
                               1, 0, 0, # u
                               0, 1, 0) # v
    sys.setWorkplane(wp)
    let p1 = sys.addPoint(10, 10)
    let p2 = sys.addPoint(20, 20)

    symmetricVertical(p1, p2)
    let res = sys.solve
    assert res == rOK

    assert p1.x ~= p2.x  
    assert p1.y ~= -p2.y

  # Symmetric regarding a line
  block:
    sys.setGroup(3)
    let wp = sys.addWorkplane( 0, 0, 100, # Origin
                               1, 0, 0, # u
                               0, 1, 0) # v
    sys.setWorkplane(wp)
    
    # Horizontal segment at y=50
    let p1 = sys.addPoint(10, 50)
    let p2 = sys.addPoint(20, 50)
    let s  = sys.addSegment(p1,p2)

    # Points we want to be symmetric
    let p3 = sys.addPoint(-30, 60)
    let p4 = sys.addPoint(90, 70)

    symmetricLine(p3, p4, s)
    let res = sys.solve
    assert res == rOK
    echo p3.coord
    echo p4.coord
    echo (p3.y - 50.0)
    echo -(p4.y - 50.0) 
    #assert (p3.y - 50.0)  ~= -(p4.y - 50.0) 
    #assert p1.y ~= -p2.y

main()
