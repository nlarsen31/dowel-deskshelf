// Half shelf: for use against a bracket in its non-mirrored orientation
// (e.g. wall.scad, wall_through.scad). See lib/half_shelf.scad for the
// full description of what this is for. The other end of the gap uses
// half_shelf_mirrored.scad, matched to whichever orientation that
// bracket was printed in.
//
// Render:
//   openscad -o export/half_shelf.stl scad/half_shelf.scad

include <lib/half_shelf.scad>

half_shelf();
