// Flat-top tray: rests on the dowels. The underside of the slab sits at
// the dowel centerline, with a half-round cradle for each dowel; only the
// two outer dowels get a clip that wraps below the centerline, to save
// filament. Dowel axes run along X at z=0 in this file's frame; the flat
// top is at z=tray_height.
//
// Render:
//   openscad -o export/tray.stl scad/tray.scad

include <lib/bracket.scad>

function dowel_y(i) = dowel_edge_margin + dowel_bore_d / 2 + i * dowel_spacing;

// Cross-section of a clip in (y, z): y in [0, w], z in [-h, 1], sharp
// everywhere except the outer bottom corner (at y=0, z=-h), which is
// rounded. The +1 overlaps the slab so the two fuse.
module clip_profile(w, h, r) {
    rc = max(min(r, h), 0.01);
    hull() {
        translate([rc, -h + rc]) circle(r = rc);
        translate([0, -h + rc]) square([w, h + 1 - rc]);
        translate([rc, -h]) square([w - rc, h + 1]);
    }
}

// Extrudes clip_profile along X. Outer (rounded) side is at low Y.
module clip(w, h, r) {
    rotate([90, 0, 90])
        linear_extrude(height = tray_length)
            clip_profile(w, h, r);
}

module tray() {
    // Each clip only covers the outer half: from the tray's outer edge
    // in to the dowel centerline.
    clip_w = dowel_bore_d / 2 + tray_clip_wall;

    difference() {
        union() {
            rounded_box([tray_length, tray_width, tray_height], tray_corner_radius);

            // First dowel: outer side is low Y.
            translate([0, dowel_y(0) - clip_w, 0])
                clip(clip_w, tray_wrap_depth, tray_corner_radius);

            // Last dowel: mirrored so the outer side is high Y.
            translate([0, dowel_y(num_dowels - 1) + clip_w, 0])
                mirror([0, 1, 0])
                    clip(clip_w, tray_wrap_depth, tray_corner_radius);
        }

        for (i = [0 : num_dowels - 1])
            translate([-1, dowel_y(i), 0])
                rotate([0, 90, 0])
                    cylinder(h = tray_length + 2, d = dowel_bore_d);
    }
}

tray();
