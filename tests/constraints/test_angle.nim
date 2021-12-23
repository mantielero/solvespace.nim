#[ discard """
output: '''
'''
""" ]#
import solvespace

proc main =
  var sys = newSystem()
  sys.setGroup(1)
 
  let wp = sys.addWorkplane( 0, 0, 0, # Origin
                             1, 0, 0, # u
                             0, 1, 0) # v
  # New workplane and group
  sys.setWorkplane( wp )
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


main()