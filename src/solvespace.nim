const libPath  = "/usr/lib/solvespace"
const libName = "slvs"
{.passL: "-L" &  libPath.}
{.passL: "-Wl,-rpath," &  libPath.}
{.passL: "-l" &  libName.}



import wrapper/slvs
export slvs

import lib/[constants, types, system, params, point3d, segment, constraints, quaternion, drag, workplane, normal, solve, point2d, arcofcircle]
export constants, types, system, params, point3d, segment, constraints, quaternion, drag, workplane, normal, solve, point2d, arcofcircle


import lib/[distance, circle, showing]
export distance, circle, showing


