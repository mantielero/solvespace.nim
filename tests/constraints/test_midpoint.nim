import solvespace

proc main =
  var sys = newSystem()

  # Segments of equal lengths
  block:
    sys.setGroup(1)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10, 10)
    let p2 = sys.addPoint(10, 10, 60)
    let s1 = sys.addSegment(p1, p2) 

    let p3 = sys.addPoint(100, 100, 100)

    
    midpoint( p3, s1) #.length(100)

    let res = sys.solve

    assert res == rOK 
    assert measureDistance(p1,p3)  ~= measureDistance(p2,p3) 


main()
