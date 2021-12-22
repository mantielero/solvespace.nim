#[
An example of a constraint in 2d. In our first group, we create a workplane
along the reference frame's xy plane. In a second group, we create some
entities in that group and dimension them.

The original demo returns:
solved okay
line from (10.000 11.180) to (10.000 -18.820)
arc center (101.114 119.042) start (116.477 111.762) finish (117.409 114.197)
circle center (200.000 200.000) radius 17.000
6 DOF  
]#
import solvespace

proc main =
  var sys = newSystem()
  sys.setGroup(1)

  let wp = sys.addWorkplane( 0, 0, 0, # Origin
                             1, 0, 0, 
                             0, 1, 0)
  sys.setWorkplane( wp )

  # Now create a second group. We'll solve group 2, while leaving group 1
  # constant; so the workplane that we've created will be locked down,
  # and the solver can't move it. 
  sys.setGroup(2)

  # These points are represented by their coordinates (u v) within the
  # workplane, so they need only two parameters each.
  let p1 = sys.addPoint(10, 20)
  let p2 = sys.addPoint(20, 10)

  # And we create a line segment with those endpoints. 
  let segment = sys.addSegment(p1, p2)

  # Now three more points.
  let pCenter = sys.addPoint(100, 120)
  let pStart  = sys.addPoint(120, 110)
  let pFinish = sys.addPoint(115, 115)

  # And arc, centered at point 303, starting at point 304, ending at
  # point 305.
  let normal = wp.getNormal#sys.getNormal(wp)
  let aoc1 = sys.addArcOfCircle(normal, pCenter, pStart, pFinish)

  # And a complete circle, centered at point 306 with radius equal to
  # distance 307. The normal is 102, the same as our workplane.
  let center = sys.addPoint(200, 200)
  let circle = sys.addCircle( center, normal, 30)

  # The length of our line segment is 30.0 units.
  segment.length( 30 )

  # And the distance from our line segment to the origin is 10.0 units.
  let origin = wp.getOrigin  #sys.getOrigin(wp)
  
  distance(origin, segment, 10)

  # And the line segment is vertical.
  segment.vertical

  # And the distance from one endpoint to the origin is 15.0 units.
  distance( origin, p1, 15)

  # And same for the other endpoint; so if you add this constraint then
  # the sketch is overconstrained and will signal an error.
  if false:  
    distance(origin, p2, 18)


  # The arc and the circle have equal radius.
  equalRadius(aoc1, circle)

  # The arc has radius 17.0 units.
  aoc1.radius(17) #sys.constrainDiameter(aoc1, 17 * 2) 

  # SOLVE
  let res = sys.solve
  if res == rOK:
    echo "Solving: ok"
    let seg = sys.getEntity(segment)
    let pid1 = seg.point[0]
    let pid2 = seg.point[1]
    let paramId1 = sys.getEntity(pid1).param[0]
    let paramId2 = sys.getEntity(pid1).param[1]  
    sys.showEntities()
    echo "DOF: ", sys.getDOF
  else:
    echo sys.sys.faileds
    var failed = cast[ptr UncheckedArray[IdConstraint]](sys.sys.failed)
    for i in 0..<sys.sys.faileds:
      echo failed[i]
    if res == rInconsistent:
      echo "system inconsistent"
    else:
      echo "system nonconvergent"

main()

