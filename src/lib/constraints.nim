#[
TYPES OF CONSTRAINTS
====================

Many constraints can apply either in 3d, or in a workplane. This is
determined by the wrkpl member of the constraint. If that member is set
to SLVS_FREE_IN_3D, then the constraint applies in 3d. If that member
is set equal to a workplane, the constraint applies projected into that
workplane. (For example, a constraint on the distance between two points
actually applies to the projected distance).

Constraints that may be used in 3d or projected into a workplane are
marked with a single star (*). Constraints that must always be used with
a workplane are marked with a double star (**). Constraints that ignore
the wrkpl member are marked with no star.

]#

import constraints/[general, angle, coincident, diameter, distance, dragged]
import constraints/[horizontal, length, midpoint, on, orientation]
import constraints/[symmetric, tangent, vertical]

export general, angle, coincident, diameter, distance, dragged
export horizontal, length, midpoint, on, orientation
export symmetric, tangent, vertical




