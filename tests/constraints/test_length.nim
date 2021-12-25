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

  # Equal distance from a point to two different segments
  block:
    sys.setGroup(4)

    let p0 = sys.addPoint(50,50,50)

    # Lets create two segments
    let p1 = sys.addPoint(10, 10, 10)
    let p2 = sys.addPoint(10, 10, 60)
    let s1 = sys.addSegment(p1, p2)
    p1.dragged
    p2.dragged

    let p3 = sys.addPoint(100, 100, 100)
    let p4 = sys.addPoint(100, 100, 200)
    let s2 = sys.addSegment(p3, p4) 
    p3.dragged
    p4.dragged



    p0.equalDistance( s1, s2 )
    echo measureDistance(p0,s1)
    echo measureDistance(p0,s2)
    echo "DOF: ", sys.getDOF
    let res = sys.solve

    assert res == rOK 
    echo measureDistance(p0,s1) 
    echo measureDistance(p0,s2)
    echo p1.coord
    echo p2.coord
    echo p3.coord
    echo p4.coord
    echo p0.coord
    #assert measureDistance(p0,s1) ~= measureDistance(p0,s2) 

  block:
    sys.setGroup(5)

    # Lets create two segments
    let p1 = sys.addPoint(10, 10, 10)
    let p2 = sys.addPoint(10, 10, 60)
    let s1 = sys.addSegment(p1, p2)

    # Arc of circle
    let normal = sys.addNormal( 1, 0, 0,
                                0, 1, 0 ) 
    let pCenter = sys.addPoint(100, 120, 300)
    let pStart  = sys.addPoint(120, 110, 300)
    let pFinish = sys.addPoint(115, 115, 300)
    let aoc = sys.addArcOfCircle(normal, pCenter, pStart, pFinish)

    equalLength( s1, aoc )

    #sys.showEntities
    let res = sys.solve

    assert res == rOK 
    #echo measureDistance(p1, p2)
    echo "Distances"
    echo "  - segment: ", measureDistance(p1,p2)
    echo "     p1: ", p1.coord
    echo "     p2: ", p2.coord    
    echo "  - arcofcircle: ", aoc.length
    echo "    center: ", pCenter.coord
    echo "    start:  ", pStart.coord
    echo "    finish: ", pFinish.coord    
    #assert measureDistance(p1,p2) ~= aoc.length

main()
