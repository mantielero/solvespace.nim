/*
$ gcc issue1.c -L/usr/lib/solvespace  -Wl,-rpath,/usr/lib/solvespace -lslvs  -o issue1
$ ./issue1
solved failed

*/
#ifdef WIN32
#   include <windows.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#include <slvs.h>

static Slvs_System sys;

static void *CheckMalloc(size_t n)
{
    void *r = malloc(n);
    if(!r) {
        printf("out of memory!\n");
        exit(-1);
    }
    return r;
}

/*-----------------------------------------------------------------------------
 * An example of a constraint in 3d. We create a single group, with some
 * entities and constraints.
 *---------------------------------------------------------------------------*/
void Issue()
{
    Slvs_hGroup g;
    double qw, qx, qy, qz;

    g = 1;
    /* First, we create our workplane. Its origin corresponds to the origin
     * of our base frame (x y z) = (0 0 0) */
    sys.param[sys.params++] = Slvs_MakeParam(1, g, 0.0);
    sys.param[sys.params++] = Slvs_MakeParam(2, g, 0.0);
    sys.param[sys.params++] = Slvs_MakeParam(3, g, 100.0);
    sys.entity[sys.entities++] = Slvs_MakePoint3d(101, g, 1, 2, 3);
    /* and it is parallel to the xy plane, so it has basis vectors (1 0 0)
     * and (0 1 0). */
    Slvs_MakeQuaternion(1, 0, 0,
                        0, 1, 0, &qw, &qx, &qy, &qz);
    sys.param[sys.params++] = Slvs_MakeParam(4, g, qw);
    sys.param[sys.params++] = Slvs_MakeParam(5, g, qx);
    sys.param[sys.params++] = Slvs_MakeParam(6, g, qy);
    sys.param[sys.params++] = Slvs_MakeParam(7, g, qz);
    sys.entity[sys.entities++] = Slvs_MakeNormal3d(102, g, 4, 5, 6, 7);

    sys.entity[sys.entities++] = Slvs_MakeWorkplane(200, g, 101, 102);




    /* and a point at (200 200 200) */
    sys.param[sys.params++] = Slvs_MakeParam(8, g, 200.0);
    sys.param[sys.params++] = Slvs_MakeParam(9, g, 200.0);
    sys.param[sys.params++] = Slvs_MakeParam(10, g, 200.0);
    sys.entity[sys.entities++] = Slvs_MakePoint3d(103, g, 8, 9, 10);


    /* The distance between the points should be 30.0 units. */
    sys.constraint[sys.constraints++] = Slvs_MakeConstraint(
                                            1, g,
                                            SLVS_C_PT_PLANE_DISTANCE,
                                            SLVS_FREE_IN_3D,
                                            400.0,
                                            103, 0, 200, 0);


    /* Now that we have written our system, we solve. */
    Slvs_Solve(&sys, g);

    if(sys.result == SLVS_RESULT_OKAY) {
        printf("okay; now at (%.3f %.3f %.3f)\n"
               "             (%.3f %.3f %.3f)\n",
                sys.param[0].val, sys.param[1].val, sys.param[2].val,
                sys.param[7].val, sys.param[8].val, sys.param[9].val);
        printf("%d DOF\n", sys.dof);
    } else {
        printf("solve failed");
    }
}


int main()
{
    sys.param      = CheckMalloc(50*sizeof(sys.param[0]));
    sys.entity     = CheckMalloc(50*sizeof(sys.entity[0]));
    sys.constraint = CheckMalloc(50*sizeof(sys.constraint[0]));

    sys.failed  = CheckMalloc(50*sizeof(sys.failed[0]));
    sys.faileds = 50;

    Issue();

    return 0;
}
