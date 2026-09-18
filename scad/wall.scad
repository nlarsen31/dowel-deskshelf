// Wall-end bracket (left half): 3D-printed piece that mounts to the wall
// and captures one end of each dowel and the shelf panel. The other end
// of the shelf is wall_mirrored.scad — a mirror image of this piece.
//
// Render:
//   openscad -o export/wall.stl scad/wall.scad

include <lib/bracket.scad>

wall_bracket();
