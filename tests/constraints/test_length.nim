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
    let p4 = sys.addPoint(100, 100, 200)
    let s2 = sys.addSegment(p3, p4) 
    
    equalLength( s1, s2) #.length(100)

    let res = sys.solve

    assert res == rOK 
    assert measureDistance(p1,p2)  ~= measureDistance(p3,p4) 

  # The distance ratio between two segments 
  block:
    sys.setGroup(2)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10, 10)
    let p2 = sys.addPoint(10, 10, 60)
    let s1 = sys.addSegment(p1, p2) 

    let p3 = sys.addPoint(100, 100, 100)
    let p4 = sys.addPoint(100, 100, 200)
    let s2 = sys.addSegment(p3, p4) 
    
    lengthRatio( s1, s2, 0.5 ) #.length(100)

    let res = sys.solve

    assert res == rOK 
    assert measureDistance(p1,p2)  ~= measureDistance(p3,p4) / 2.0

  # The distance ratio between two segments 
  block:
    sys.setGroup(3)

    # Lets create two horizontal line
    let p1 = sys.addPoint(10, 10, 10)
    let p2 = sys.addPoint(10, 10, 60)
    let s1 = sys.addSegment(p1, p2) 

    let p3 = sys.addPoint(100, 100, 100)
    let p4 = sys.addPoint(100, 100, 200)
    let s2 = sys.addSegment(p3, p4) 
    
    lengthDiff( s1, s2, 10 ) #.length(100)

    let res = sys.solve

    assert res == rOK 
    assert measureDistance(p1,p2) ~= (measureDistance(p3,p4) + 10.0)

main()
