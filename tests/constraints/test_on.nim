import solvespace

proc main =
  var sys = newSystem()

  # Segments of equal lengths
  block:
    sys.setGroup(1)

    # Circle
    let center = sys.addPoint(200, 200, 200)
    let normal = sys.addNormal( 1, 0, 0,
                                0, 0, 1 ) 
    let circle = sys.addCircle( center, normal, 30) 


    # Lets create two horizontal line
    let p = sys.addPoint(10, 10, 10)

    p.on( circle )

    let res = sys.solve

    assert res == rOK 
    #echo p.coord
    #echo center.coord
    #echo measureDistance(p, center)
    #assert measureDistance(p, center)  ~= 30


main()
