// Shared helpers for tray-like pieces that rest on the dowel row and
// snap-clip around it. Included by tray.scad and half_tray.scad.

include <bracket.scad>

function dowel_y(i) = dowel_edge_margin + dowel_bore_d / 2 + i * dowel_spacing;

// Cross-section of a clip in (y, z): y in [0, w], z in [-h, r+1], sharp
// everywhere except the outer bottom corner (at y=0, z=-h), which is
// rounded. The top reaches past the slab's rounded bottom edge (radius r) so the clip fills that curve.
module clip_profile(w, h, r) {
    rc = max(min(r, h), 0.01);
    hull() {
        translate([rc, -h + rc]) circle(r = rc);
        translate([0, -h + rc]) square([w, h + r + 1 - rc]);
        translate([rc, -h]) square([w - rc, h + r + 1]);
    }
}

// Extrudes clip_profile along X for `length`. Outer (rounded) side is at low Y.
module clip(w, h, r, length) {
    rotate([90, 0, 90])
        linear_extrude(height = length)
            clip_profile(w, h, r);
}
