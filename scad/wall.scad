// Wall-end bracket: 3D-printed piece that mounts to the wall and
// captures one end of a wooden dowel shelf support.
//
// Render a single bracket:
//   openscad -o export/wall.stl scad/wall.scad
//
// Preview both left/right mirrored brackets together by setting
// render_pair = true below (handy for eyeballing fit).

include <lib/params.scad>

render_pair = false;

module wall_bracket() {
    bore_d = dowel_diameter + dowel_tolerance;

    difference() {
        // Main block, flush against the wall on its back (X=0) face.
        cube([wall_bracket_depth, wall_bracket_width, wall_bracket_height]);

        // Dowel socket: blind hole bored in from the front face,
        // centered on the block, running along the depth (X) axis.
        translate([wall_bracket_depth - dowel_bore_depth,
                   wall_bracket_width / 2,
                   wall_bracket_height / 2])
            rotate([0, 90, 0])
                cylinder(h = dowel_bore_depth + 1, d = bore_d);

        // Wall mounting holes: through-holes along the depth axis,
        // near the back face, evenly spaced vertically.
        for (i = [0 : mount_hole_count - 1]) {
            frac = (mount_hole_count == 1) ? 0.5
                 : mount_hole_inset / wall_bracket_height
                   + i * (wall_bracket_height - 2 * mount_hole_inset)
                     / (wall_bracket_height * (mount_hole_count - 1));
            translate([-1, wall_bracket_width / 2, frac * wall_bracket_height])
                rotate([0, 90, 0])
                    cylinder(h = wall_bracket_depth + 2, d = mount_hole_diameter);
        }
    }
}

if (render_pair) {
    wall_bracket();
    translate([0, wall_bracket_width + 20, 0])
        mirror([0, 1, 0])
            wall_bracket();
} else {
    wall_bracket();
}
