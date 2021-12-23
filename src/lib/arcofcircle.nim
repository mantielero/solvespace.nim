import ../wrapper/slvs
import types, constants, system, tools

proc addArcOfCircle( sys:var System; 
                     normal, center, start, `end`:IdEntity; 
                     workplane:Workplane; group:IdGroup = 0):ArcOfCircle =
  var grp = group
  if grp == 0:
    grp = sys.groupNewId    
  result.id = sys.entityNewId  #.ArcOfCircle
  result.sys = sys
  sys.entities &= Slvs_MakeArcOfCircle( result.IdEntity, grp, 
                                        workplane.IdEntity, 
                                        normal, center, start, `end` )
  sys.entityNewId += 1


# Point3d
proc addArcOfCircle*( sys:var System; 
                     normal:Normal3d; center, start, `end`: Point3d; 
                     workplane:Workplane; group:IdGroup):ArcOfCircle  =
  addArcOfCircle( sys, normal.IdEntity, center.IdEntity, start.IdEntity, `end`.IdEntity, 
                     workplane, group )


proc addArcOfCircle*( sys:var System; 
                     normal:Normal3d; center, start, `end`: Point3d):ArcOfCircle  =
  addArcOfCircle( sys, normal, center, start, `end`,  
                  sys.currentWorkplane, sys.currentGroup)

# Point2d
proc addArcOfCircle*( sys:var System; 
                     normal:Normal3d; center, start, `end`: Point2d; 
                     workplane:Workplane; group:IdGroup = 0):ArcOfCircle  =
  addArcOfCircle( sys, normal.IdEntity, center.IdEntity, start.IdEntity, `end`.IdEntity, 
                     workplane, group )

proc addArcOfCircle*( sys:var System; 
                     normal:Normal3d; center, start, `end`: Point2d):ArcOfCircle  =
  addArcOfCircle( sys, normal, center, start, `end`,  
                  sys.currentWorkplane, sys.currentGroup)

#[
    sys.entity[sys.entities++] = Slvs_MakeArcOfCircle(401, g, 200, 102,
                                    303, 304, 305);

proc Slvs_MakeArcOfCircle*(h: Slvs_hEntity; group: Slvs_hGroup;
                           wrkpl: Slvs_hEntity; 
                           normal: Slvs_hEntity;
                           center: Slvs_hEntity; start: Slvs_hEntity;
                           `end`: Slvs_hEntity): Slvs_Entity                                   
]#

proc radius*(aoc:ArcOfCircle):float =
  let points = aoc.sys.getEntity(aoc.id).point
  var p1,p2:Point3d
  p1.id = points[0]
  p1.sys = aoc.sys
  p2.id = points[1]
  p2.sys = aoc.sys  
  measureDistance(p1, p2)