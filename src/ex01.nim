#[
Example: creates a couples of points and impose a constraint on the distance between them  
]#
import solvespace

proc main =
  # This will contain a single group, which will arbitrarily number 1.
  var g:Slvs_hGroup = 1
  
  var params:seq[Slvs_Param]
  var entities:seq[Slvs_Entity]
  var constraints:seq[Slvs_Constraint]
  var dragged:seq[int]

  # A point, initially at (x y z) = (10 10 10)
  params &= Slvs_MakeParam(1, g, 10.0)  # sys.param[sys.params++] = Slvs_MakeParam(1, g, 10.0);
  params &= Slvs_MakeParam(2, g, 10.0)  
  params &= Slvs_MakeParam(3, g, 10.0)

  entities &= Slvs_MakePoint3d(101, g, 1, 2, 3) # sys.entity[sys.entities++] = Slvs_MakePoint3d(102, g, 4, 5, 6);
  
  # and a second point at (20 20 20)
  params &= Slvs_MakeParam(4, g, 20.0)
  params &= Slvs_MakeParam(5, g, 20.0)  
  params &= Slvs_MakeParam(6, g, 20.0)  

  entities &= Slvs_MakePoint3d(102, g, 4, 5, 6) # sys.entity[sys.entities++] = Slvs_MakePoint3d(102, g, 4, 5, 6);

  # and a line segment connecting them.
  entities &= Slvs_MakeLineSegment(200, g, SLVS_FREE_IN_3D, 101, 102)
  

  # The distance between the points should be 30.0 units.
  constraints &= Slvs_MakeConstraint(  1, g, SLVS_C_PT_PT_DISTANCE, SLVS_FREE_IN_3D,  30.0,
                                      101, 102, 0, 0 )
                                    


  #static Slvs_System sys;
  var sys:Slvs_System
  sys.params = params.len.cint
  sys.entities = entities.len.cint
  sys.constraints = constraints.len.cint
  sys.param      = cast[ptr UncheckedArray[Slvs_Param]](params[0].unsafeAddr)
  sys.entity     = cast[ptr UncheckedArray[Slvs_Entity]](entities[0].unsafeAddr)
  sys.constraint = cast[ptr UncheckedArray[Slvs_Constraint]](constraints[0].unsafeAddr)
  
  # Let's tell the solver to keep the second point as close to constant
  # as possible, instead moving the first point.
  sys.dragged[0] = 1
  sys.dragged[1] = 2
  sys.dragged[2] = 3  

  # Now that we have written our system, we solve.params
  Slvs_Solve(sys.unsafeAddr, g)

  if sys.result == SLVS_RESULT_OKAY:
    echo "okay; now at: ", sys.param[0].val, " ", sys.param[1].val, " ", sys.param[2].val
    echo "            : ", sys.param[3].val, " ", sys.param[4].val, " ", sys.param[5].val
    echo  sys.dof, " DOF"
  else:
    echo "solve failed"

main()
