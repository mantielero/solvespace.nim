import solvespace, math

proc main =
  var sys = newSystem()
  
  # Preparation
  sys.setGroup(1)
  let a = sys.addPoint(200, 200, 200)
  let b = sys.addPoint(200, 200, 300) 
  let s = sys.addSegment(a,b)
  let p = sys.addPoint(0, 0, 0)  # The distance will be sqrt(200² + 200²)

  # Vector
  let ab = vector(a,b)
  assert ab == (0.0,0.0,100.0)

  # Dot product
  assert dotProduct((1.0,0.0,0.0), (0.0,1.0,0.0) ) == 0.0
  assert (1.0,0.0,0.0) * (5.0,1.0,0.0)  == 5.0

  # Cross product
  assert crossProduct((1.0,0.0,0.0), (0.0,1.0,0.0) ) == (0.0,0.0,1.0)     
  assert ( (1.0,0.0,0.0) ^ (0.0,1.0,0.0) ) == (0.0,0.0,1.0)    

  # Distance P - Line
  assert measureDistance(p, s) == sqrt(200.0^2 + 200.0^2)
  
  # Distance
  let wp = sys.addWorkplane( 0,0,0,
                             1,0,0,
                             0,1,0)
  let n = wp.normal
  assert n == (0.0,0.0,1.0)
  let pp = sys.addPoint(100, 200, 300)

  assert measureDistance(pp, wp) == 300.0

main()