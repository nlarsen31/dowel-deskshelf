// Shared geometry for the wall-end bracket. Included by wall.scad and
// wall_mirrored.scad so both halves of the shelf stay in sync.

include <params.scad>

// Box with all 12 edges filleted to radius r, spanning [0,0,0] to size.
module rounded_box(size, r) {
    hull() {
        for (x = [r, size[0] - r])
            for (y = [r, size[1] - r])
                for (z = [r, size[2] - r])
                    translate([x, y, z]) sphere(r = r);
    }
}

// A blind bore of diameter d and depth `depth`, aligned along +Z from
// z=0 (blind end) to z=depth (opening), with a concave fillet of radius
// `fillet_r` rounding the edge where the bore meets the opening face.
// Extends 1mm past z=depth so the opening cuts cleanly through a face.
module rounded_bore(d, depth, fillet_r) {
    r = d / 2;
    steps = 8;
    arc = [for (i = [0 : steps])
        let (theta = 180 - i * (90 / steps))
        [r + fillet_r + fillet_r * cos(theta), (depth - fillet_r) + fillet_r * sin(theta)]
    ];
    profile = concat(
        [[0, 0], [r, 0]],
        arc,
        [[r + fillet_r, depth + 1], [0, depth + 1]]
    );
    rotate_extrude(angle = 360)
        polygon(points = profile);
}

module wall_bracket() {
    difference() {
        // Main block, flush against the wall on its back (X=0) face,
        // with rounded corners/edges everywhere.
        rounded_box([wall_bracket_depth, wall_bracket_width, wall_bracket_height], corner_radius);

        // Dowel row: blind holes bored in from the front face, running
        // along the depth (X) axis, evenly spaced along the top edge.
        for (i = [0 : num_dowels - 1]) {
            y = dowel_edge_margin + dowel_bore_d / 2 + i * dowel_spacing;
            z = wall_bracket_height - dowel_row_offset;
            translate([wall_bracket_depth - dowel_bore_depth, y, z])
                rotate([0, 90, 0])
                    rounded_bore(dowel_bore_d, dowel_bore_depth, dowel_fillet_r);
        }

        // Shelf panel slot: open on the same front face as the dowel
        // bores (X = wall_bracket_depth), running along Y nearly the
        // full width, blind at shelf_slot_depth back from that face.
        translate([wall_bracket_depth - shelf_slot_depth,
                   shelf_slot_margin,
                   shelf_slot_z - shelf_slot_h / 2])
            cube([shelf_slot_depth + 1, shelf_slot_w, shelf_slot_h]);

        // Rubber foot recesses: shallow pockets in the bottom face,
        // one near each of the four bottom corners.
        for (x = [foot_inset, wall_bracket_depth - foot_inset])
            for (y = [foot_inset, wall_bracket_width - foot_inset])
                translate([x, y, -0.1])
                    cylinder(h = foot_recess_depth + 0.1, d = foot_diameter);
    }
}
