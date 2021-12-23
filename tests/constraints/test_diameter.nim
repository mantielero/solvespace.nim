#[ discard """
output: '''
'''

""" ]#
import solvespace

proc main =
  var sys = newSystem()

  block:
    sys.setGroup(1)

    # Circle
    let center = sys.addPoint(200, 200, 200)
    let normal = sys.addNormal( 1, 0, 0,
                                0, 0, 1 ) 
    let circle = sys.addCircle( center, normal, 30) 
    # Arc of circle
    let pCenter = sys.addPoint(100, 120, 300)
    let pStart  = sys.addPoint(120, 110, 300)
    let pFinish = sys.addPoint(115, 115, 300)
    let aoc = sys.addArcOfCircle(normal, pCenter, pStart, pFinish)

    equalRadius(circle, aoc)

    let res = sys.solve
    assert res == rOK 
    assert circle.radius ~= aoc.radius

  block:
    sys.setGroup(2)

    # Circle
    let center = sys.addPoint(200, 200, 200)
    let normal = sys.addNormal( 1, 0, 0,
                                0, 0, 1 ) 
    let circle = sys.addCircle( center, normal, 30) 

    circle.diameter(50)

    let res = sys.solve
    assert res == rOK 
    assert circle.radius ~= 25

  block:
    sys.setGroup(3)

    # Circle
    let center = sys.addPoint(200, 200, 200)
    let normal = sys.addNormal( 1, 0, 0,
                                0, 0, 1 ) 
    let circle = sys.addCircle( center, normal, 30) 

    circle.radius(10)

    let res = sys.solve
    assert res == rOK 
    assert circle.radius ~= 10

main()