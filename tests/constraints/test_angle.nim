import solvespace

proc main =
  var sys = newSystem()
  sys.setGroup(1)
 
  let wp = sys.addWorkplane( 0, 0, 0, # Origin
                             1, 0, 0, # u
                             0, 1, 0) # v
  # New workplane and group
  sys.setWorkplane( wp )

  # Test constraining specific angle  
  block:
    sys.setGroup(2)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10)
    let p2 = sys.addPoint(20, 10)
    let s1 = sys.addSegment(p1, p2) 
    s1.horizontal
    #drag(p1,p2)

    let p3 = sys.addPoint(100, 100)
    let s2 = sys.addSegment(p1, p3) 

    angle(s1,s2, 90)  # So s2 should be vertical
    let res = sys.solve
    #echo res
    #echo "DOF: ", sys.getDOF
    assert res == rOK 
    assert p1.x ~= p3.x 

  # Test parallel
  block:
    sys.setGroup(3)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10)
    let p2 = sys.addPoint(20, 10)
    let s1 = sys.addSegment(p1, p2) 
    s1.horizontal # Forxing s1 remains horizontal
    s1.length(10)

    let p3 = sys.addPoint(100, 100)
    let p4 = sys.addPoint(100, 110)    
    let s2 = sys.addSegment(p3, p4) 

    parallel(s1,s2)

    let res = sys.solve
#[     echo res
    echo "DOF: ", sys.getDOF
    echo p1.coord
    echo p2.coord
    echo p3.coord
    echo p4.coord ]#
    assert res == rOK 
    assert p3.y ~= p4.y #  

  # Test parallel
  block:
    sys.setGroup(4)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10)
    let p2 = sys.addPoint(20, 10)
    let s1 = sys.addSegment(p1, p2) 
    s1.horizontal # Forxing s1 remains horizontal
    s1.length(10)

    let p3 = sys.addPoint(100, 100)
    let p4 = sys.addPoint(130, 110)    
    let s2 = sys.addSegment(p3, p4) 

    perpendicular(s1,s2)

    let res = sys.solve
    assert res == rOK 
    assert p3.x ~= p4.x  


  # Test equal angle
  block:
    sys.setGroup(5)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10)
    let p2 = sys.addPoint(20, 10)
    let s1 = sys.addSegment(p1, p2) 
    s1.horizontal # Forxing s1 remains horizontal
    s1.length(10)

    let p3 = sys.addPoint(100, 100)
    let p4 = sys.addPoint(100, 110)    
    let s2 = sys.addSegment(p3, p4) 
    perpendicular(s1,s2)

    let p5 = sys.addPoint(50, 10)
    let p6 = sys.addPoint(60, 10)
    let s3 = sys.addSegment(p5, p6) 
    s3.horizontal # Forxing s1 remains horizontal
    s3.length(10)

    let p7 = sys.addPoint(200, 100)
    let p8 = sys.addPoint(210, 210)    
    let s4 = sys.addSegment(p7, p8) 
    s4.length(10)

    equalAngle(s1,s2, s3,s4)
    let res = sys.solve

    assert res == rOK 
    assert p3.x ~= p4.x 

main()