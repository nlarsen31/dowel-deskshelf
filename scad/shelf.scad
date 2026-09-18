// Slide-in shelf panel: a flat PLA panel that spans between the left and
// right wall brackets, captured by the shelf slot cut into each bracket
// (see wall.scad). Its length is derived from dowel_length_in so it
// spans the same wall-to-wall gap as the dowels.
//
// Render:
//   openscad -o export/shelf.stl scad/shelf.scad

include <lib/params.scad>

module shelf_panel() {
    cube([shelf_length, shelf_width, shelf_thickness]);
}

shelf_panel();


