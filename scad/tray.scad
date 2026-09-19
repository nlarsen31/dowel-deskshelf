// Flat-top tray: rests on the dowels. The underside of the slab sits at
// the dowel centerline, with a half-round cradle for each dowel; only the
// two outer dowels get a clip that wraps below the centerline, to save
// filament. Dowel axes run along X at z=0 in this file's frame; the flat
// top is at z=tray_height.
//
// Render:
//   openscad -o export/tray.stl scad/tray.scad

include <lib/tray_common.scad>

module tray() {
    // Each clip only covers the outer half: from the tray's outer edge
    // in to the dowel centerline.
    clip_w = dowel_bore_d / 2 + tray_clip_wall;

    difference() {
        union() {
            rounded_box([tray_length, tray_width, tray_height], tray_corner_radius);

            // First dowel: outer side is low Y.
            translate([0, dowel_y(0) - clip_w, 0])
                clip(clip_w, tray_wrap_depth, tray_corner_radius, tray_length);

            // Last dowel: mirrored so the outer side is high Y.
            translate([0, dowel_y(num_dowels - 1) + clip_w, 0])
                mirror([0, 1, 0])
                    clip(clip_w, tray_wrap_depth, tray_corner_radius, tray_length);
        }

        for (i = [0 : num_dowels - 1])
            translate([-1, dowel_y(i), 0])
                rotate([0, 90, 0])
                    cylinder(h = tray_length + 2, d = dowel_bore_d);
    }
}

tray();
