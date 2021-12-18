#[
Example: creates a couples of points and impose a constraint on the distance between them  
]#
import solvespace

proc main =
  var sys = newSystem()
  
  let group1:IdGroup = 1                          # This will contain a single group, which will arbitrarily number 1.
  let p1 = sys.addPoint(10,10,10, group1)   # A point, initially at (x y z) = (10 10 10)
  let p2 = sys.addPoint(20,20,20, group1)   # and a second point at (20 20 20)

  let segment = sys.newSegment(group1, wpFree, p1, p2)

  # The distance between the points should be 30.0 units.
  #let constraint = sys.newConstraint(group1, wpFree, cDistancePtPt, 30.0, p1.id, p2.id)
  let constraint = sys.constrainDistance(group1, wpFree, p1, p2, 30)
                      
  # Let's tell the solver to keep the second point as close to constant
  # as possible, instead moving the first point.
  sys.drag(p2)
  var res = sys.solve(group1)

  if res == rOK:
    echo "Solver: ok"
    echo "now at:"
    echo "  p1: ", sys.sys.param[0].val, " ", sys.sys.param[1].val, " ", sys.sys.param[2].val
    echo "  p2: ", sys.sys.param[3].val, " ", sys.sys.param[4].val, " ", sys.sys.param[5].val
    echo sys.sys.dragged

  else:
    echo "Solver: failed"

main()
