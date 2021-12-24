const libPath  = "/usr/lib/solvespace"
const libName = "slvs"
{.passL: "-L" &  libPath.}
{.passL: "-Wl,-rpath," &  libPath.}
{.passL: "-l" &  libName.}
{.experimental: "unicodeOperators".} 

import std/math

import wrapper/slvs
export slvs

import lib/[constants, types, system, params, point2d, point3d, segment, cubic]
import lib/[constraints, quaternion, drag, workplane, normal2d, normal3d, solve, arcofcircle]
import lib/[tools]
export constants, types, system, params, point2d, point3d, segment, cubic
export constraints, quaternion, drag, workplane, normal2d, normal3d, solve, arcofcircle
export tools


import lib/[distance, circle, showing]
export distance, circle, showing


