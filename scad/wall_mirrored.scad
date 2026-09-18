// Wall-end bracket (right half): a mirror image of wall.scad, so the
// dowels and shelf panel are captured at both ends of the span.
//
// Render:
//   openscad -o export/wall_mirrored.stl scad/wall_mirrored.scad

include <lib/bracket.scad>

mirror([0, 1, 0])
    wall_bracket();
