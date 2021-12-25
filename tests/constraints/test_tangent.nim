import solvespace

proc main =
  var sys = newSystem()

  # Segment tangent to Arc Of Circle
  block:
    sys.setGroup(1)
    let wp = sys.addWorkplane( 0, 0, 100, # Origin
                               1, 0, 0, # u
                               0, 1, 0) # v
    sys.setWorkplane(wp)

    # Arc of circle creation
    let normal = wp.normalId
    let pCenter = sys.addPoint(0, 0)
    let pStart  = sys.addPoint(-100, 0)
    let pFinish = sys.addPoint(100, 0)
    let aoc = sys.addArcOfCircle(normal, pCenter, pStart, pFinish)

    # Add segment
    let p1 = sys.addPoint(100, 200)
    let p2 = sys.addPoint(200, 0)
    let s = sys.addSegment(p1, p2)

    tangent(s, aoc, false)
    #echo sys.constraints
    #sys.showEntities
    let res = sys.solve

    assert res == rOK
    # TODO: measure distance from point to workplane
    #echo p1
    #echo pStart
    #echo p.coord
    #echo center.coord
    #echo measureDistance(p, center)
    #assert measureDistance(p, center)  ~= 30


main()
