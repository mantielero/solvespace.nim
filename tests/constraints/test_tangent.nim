import solvespace

proc main =
  var sys = newSystem()

  # Segments of equal lengths
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
    # TODO: measure distance from point to workplane
    
    #echo p.coord
    #echo center.coord
    #echo measureDistance(p, center)
    #assert measureDistance(p, center)  ~= 30


main()
