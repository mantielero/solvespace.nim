import solvespace

proc main =
  var sys = newSystem()

  # Segments of equal lengths
  block:
    sys.setGroup(1)

    # Circle

    let n1 = sys.addNormal( 1, 0, 0,
                            0, 0, 1 ) 
    let n2 = sys.addNormal( 1, 0, 0,
                            0, 1, 0 ) 

    sameOrientation(n1, n2)
    echo n1.normal
    echo n2.normal
    let res = sys.solve
    echo res
    assert res == rOK
    #echo n1.normal
    #echo n2.normal
    #echo p.coord
    #echo center.coord
    #echo measureDistance(p, center)
    #assert measureDistance(p, center)  ~= 30

main()
