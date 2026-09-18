// Middle bracket: like wall.scad, but the dowels pass all the way
// through instead of stopping blind. Use this for an intermediate
// support along the dowel run when the slide-in shelf panel is only
// meant to cover part of the span rather than the full wall-to-wall
// distance.
//
// Render:
//   openscad -o export/wall_through.stl scad/wall_through.scad

include <lib/bracket.scad>

wall_bracket(through_dowels = true);
