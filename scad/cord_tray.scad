// Cord tray: a skinny version of tray.scad that covers only the first
// cord_tray_dowels dowels, plus a fin hanging below its low-Y edge with
// hooked slots that hold cords, to organize cables under the shelf.
// Same frame as tray.scad: dowel axes along X at z=0, flat top at
// z=tray_height.
//
// Render:
//   openscad -o export/cord_tray.stl scad/cord_tray.scad

include <lib/tray_common.scad>

module cord_tray() {
    n = cord_tray_dowels;
    w = dowel_y(n - 1) + dowel_y(0);
    clip_w = dowel_y(0);

    difference() {
        union() {
            rounded_box([cord_tray_length, w, tray_height], tray_corner_radius);

            intersection() {
                translate([0, 0, -cord_fin_drop - 1])
                    rounded_slab([cord_tray_length, w, cord_fin_drop + tray_height], tray_corner_radius);
                union() {
                    clip(clip_w, tray_wrap_depth, tray_corner_radius, cord_tray_length);
                    translate([0, w, 0])
                        mirror([0, 1, 0])
                            clip(clip_w, tray_wrap_depth, tray_corner_radius, cord_tray_length);

                    // Hanging fin, flush with the low-Y side.
                    translate([0, 0, -cord_fin_drop])
                        cube([cord_tray_length, cord_fin_thickness, cord_fin_drop + tray_corner_radius + 1]);
                }
            }
        }

        for (i = [0 : n - 1])
            translate([-1, dowel_y(i), 0])
                rotate([0, 90, 0])
                    cylinder(h = cord_tray_length + 2, d = dowel_bore_d);

        // Hooked cord slots: a neck opens at the fin's bottom edge and climbs
        // to a pocket offset to the side, so a cord slid in from below hooks
        // sideways into the pocket and can't fall back out. Only the cord
        // goes through the neck; big plugs stay outside.
        pitch = cord_tray_length / cord_slot_count;
        off = cord_slot_neck / 2 + cord_slot_d / 2 - 1;
        cz = -cord_fin_drop + cord_slot_wall + cord_slot_d / 2;
        for (i = [0 : cord_slot_count - 1]) {
            nx = pitch * (i + 0.5) - off / 2;
            translate([nx - cord_slot_neck / 2, -1, -cord_fin_drop - 1])
                cube([cord_slot_neck, cord_fin_thickness + 2, cz + cord_fin_drop + 1]);
            translate([nx + off, -1, cz])
                rotate([-90, 0, 0])
                    cylinder(h = cord_fin_thickness + 2, d = cord_slot_d);
        }
    }
}

cord_tray();
