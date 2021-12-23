import solvespace

proc main =
  var sys = newSystem()
  sys.setGroup(1)
  let wp = sys.addWorkplane( 0, 0, 0, # Origin
                             1, 0, 0, # u
                             0, 1, 0) # v
  sys.setWorkplane( wp )

  sys.setWorkplane( wp )
  sys.setGroup(2)
  let p1 = sys.addPoint(10, 20)
  let p2 = sys.addPoint(20, 10)

  # And we create a line segment with those endpoints. 
  let segment = sys.addSegment(p1, p2)    

  segment.vertical
  let res = sys.solve
  assert res == rOK 
  assert p1.x == p2.x

main()