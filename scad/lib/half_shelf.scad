// Half shelf: a reinforced, shorter version of shelf_panel.scad that
// slides into one bracket's shelf_slot groove and cantilevers out
// toward the middle of a gap instead of spanning wall-to-wall. Two of
// these -- one per bracket, printed with half_shelf.scad or
// half_shelf_mirrored.scad depending on which way that bracket's slot
// is offset -- can together carry a laptop resting across both with a
// small gap between them. This sits at the shelf_slot's height, well
// below the dowel row, and does not touch or rely on the dowels.
//
// Local frame: X=0 is the slot's front-face opening (matches
// wall_bracket_depth in bracket.scad's frame); negative X is inside the
// slot cavity. Z=0 is the underside of the panel's normal (thin)
// section, Z=shelf_thickness is its top -- both match shelf_panel.scad's
// own frame, and the top surface stays at that same Z the whole way out
// so a laptop resting across two of these sits flat.
//
// A flat panel at shelf_thickness would sag/snap cantilevered this far,
// so material is added below the top surface near the root (inside the
// slot opening, where the bending load is highest) and tapers back down
// to the normal thickness over half_shelf_taper_length. If that's still
// not stiff enough for the load, half_shelf_leg_drop adds a support leg
// near the far end that lets the shelf rest on the desk below -- fine,
// but not preferred over staying cantilevered.

include <bracket.scad>

module half_shelf() {
    // Tab: identical slide-fit geometry to shelf_panel.scad's own edge,
    // captured in the bracket's existing shelf_slot.
    module tab() {
        translate([-shelf_slot_depth, 0, 0])
            cube([shelf_slot_depth, shelf_width, shelf_thickness]);
    }

    // Tapered root: wedge-shaped underside reinforcement, thickest at
    // the slot opening (X=0) and back to normal thickness by
    // X=half_shelf_taper_length. Built as a hull of two thin slivers so
    // the taper is linear.
    module root_taper() {
        hull() {
            translate([0, 0, shelf_thickness - half_shelf_root_height])
                cube([0.01, shelf_width, half_shelf_root_height]);
            translate([half_shelf_taper_length - 0.01, 0, 0])
                cube([0.01, shelf_width, shelf_thickness]);
        }
    }

    // Flat run: normal shelf_thickness slab from the end of the taper
    // out to the unsupported tip, with the tip's two outer corners
    // rounded (the near end here butts against the taper, so it stays
    // square).
    module flat_run() {
        translate([half_shelf_taper_length, 0, 0])
            rounded_tip_slab(half_shelf_length - half_shelf_taper_length, shelf_width, shelf_thickness, shelf_corner_radius);
    }

    // Optional last-resort leg: drops from the underside near the tip
    // down to desk height. Disabled (zero-height) unless
    // half_shelf_leg_drop is set.
    module leg() {
        if (half_shelf_leg_drop > 0)
            translate([half_shelf_length - half_shelf_leg_length, 0, -half_shelf_leg_drop])
                cube([half_shelf_leg_length, shelf_width, half_shelf_leg_drop]);
    }

    union() {
        tab();
        root_taper();
        flat_run();
        leg();
    }
}
