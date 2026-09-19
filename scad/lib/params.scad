// Shared parameters for the dowel desk shelf.
// Internally everything is mm (OpenSCAD's native unit); inch inputs are
// converted right where they're defined.

function in_to_mm(v) = v * 25.4;

// --- Dowel ---
// Standard inch dowel stock: 1/4, 3/8, 1/2, 5/8, 3/4, 1"
dowel_diameter_in = 3/4;
dowel_diameter    = in_to_mm(dowel_diameter_in);
dowel_tolerance   = 0.3;  // added to bore diameter for a snug press/slide fit
dowel_bore_depth  = 25;   // how far the dowel is captured inside the wall piece
dowel_length_in   = 36;   // length of the dowel rod stock, wall-mount face to wall-mount face
dowel_length      = in_to_mm(dowel_length_in);

// --- Dowel row (top edge of the wall bracket) ---
num_dowels        = 6;
dowel_min_wall    = 6;    // min plastic left between adjacent dowel bores
dowel_edge_margin = 10;   // plastic left outboard of the first/last dowel
dowel_row_offset  = 15;   // distance from the top edge down to the hole row
dowel_fillet_r    = 2;    // rounds the edge where each bore opens on the front face

dowel_bore_d   = dowel_diameter + dowel_tolerance;
dowel_spacing  = dowel_bore_d + dowel_min_wall; // center-to-center

// --- Wall bracket block ---
// "width" runs along the wall (left-right), "height" is vertical,
// "depth" is how far the block sticks out from the wall (front-back).
// Width is derived so all dowels fit with the margins/spacing above.
wall_bracket_width  = (num_dowels - 1) * dowel_spacing + dowel_bore_d + 2 * dowel_edge_margin;
wall_bracket_height = 140;
wall_bracket_depth  = dowel_bore_depth + 10; // bore depth + material behind it
corner_radius       = 4; // fillet radius on all 12 edges of the block

// --- Shelf panel slot ---
// A second, flat PLA shelf panel spans between the left and right wall
// brackets the same way the dowels do. Each bracket has a slot open on
// the same face as the dowel bores (X = wall_bracket_depth), running
// along Y nearly the full width, blind at shelf_slot_depth back from
// that face.
shelf_thickness  = 2;    // panel thickness the slot is sized around
shelf_clearance  = 0.3;  // added to slot height for a slide fit
shelf_slot_depth  = 15;  // along X, how far the panel is captured from the front face
shelf_slot_margin = 8;   // along Y, inset from the bracket's left/right edges
shelf_slot_z      = 30;  // height of the slot's vertical center, from the bottom

shelf_slot_h = shelf_thickness + shelf_clearance;
shelf_slot_w = wall_bracket_width -  shelf_slot_margin; // slot's extent along Y

// --- Shelf panel ---
// The panel that actually slides into the slot above.
shelf_width_clearance = 0.5; // subtracted from the slot width for an easy slide fit
shelf_corner_radius  = 2;    // rounds the panel's corners (kept well under half of shelf_thickness's plan dimensions)
// shelf_length = dowel_length - 2 * dowel_bore_depth + 2 * shelf_slot_depth; // total panel length, including the ends captured in each bracket's slot
shelf_length = 250;
shelf_width  = shelf_slot_w - shelf_width_clearance;

// --- Flat-top tray ---
// A printed surface that rests on the dowels: flat on top, with a
// half-round channel on the underside for each dowel so it cradles them.
// The channels line up with the bracket's dowel row (same Y positions).
tray_length        = 250; // along the dowels (X); sized for a 256x256 print bed
tray_top_thickness = 4;   // material above the top of the dowels
tray_wrap_depth    = 6;   // how far the clips on the two OUTER dowels extend below the
                          // dowel centerline (keep < dowel radius, ~9.7mm, or the channel
                          // becomes a closed tunnel; ~6 gives a snap-fit)
tray_clip_wall     = 3;   // plastic around each outer dowel's clip
tray_corner_radius = 2;   // rounds the tray's edges

tray_width  = wall_bracket_width; // spans the same dowel row as the brackets
tray_height = dowel_bore_d / 2 + tray_top_thickness; // flat slab; clips hang below it

// --- Half shelf (laptop support) ---
// A shorter, reinforced version of the shelf panel: slides into one
// bracket's shelf_slot groove (same slot, same fit as shelf_panel.scad)
// and cantilevers out toward the middle instead of spanning wall-to-wall.
// Use one against each of two brackets bounding a gap, so together they
// carry a laptop resting across both with a small gap between them.
// It sits below the dowel row and does not touch or rely on the dowels
// at all -- only the slot anchors it.
//
// A flat panel at shelf_thickness would sag/snap cantilevered this far,
// so the part captured in the slot tapers up to half_shelf_root_height
// and steps back down to shelf_thickness over half_shelf_taper_length,
// trading some slot clearance for a much stiffer root where the bending
// load is highest. If that's still not stiff enough, half_shelf_leg_drop
// adds a short leg near the far end that lets it rest on the desk below
// rather than stay fully cantilevered -- fine but not preferred.
half_shelf_length        = 120;  // total length from the slot's front-face
                                  // opening to the far (unsupported) end;
                                  // tune so two of these leave a small gap
                                  // at the midpoint of your actual span
half_shelf_root_height   = 12;   // thickness at the root (inside the slot
                                  // opening), tapering down to shelf_thickness
half_shelf_taper_length  = 40;   // how far along half_shelf_length the taper
                                  // from root_height down to shelf_thickness runs
half_shelf_leg_drop      = 0;    // extra material dropped from the underside
                                  // near the far end down to desk height, as a
                                  // last-resort support (0 disables it; set to
                                  // the measured gap from shelf underside to
                                  // desk surface to enable)
half_shelf_leg_length    = 20;   // how much of the far end the leg spans

// --- Rubber feet ---
// Shallow recesses in the bottom face (Z=0) so self-adhesive rubber feet
// sit flush, one near each of the four bottom corners.
// foot_diameter_in  = 0.25;
//foot_diameter     = in_to_mm(foot_diameter_in);
foot_diameter = 12;
foot_recess_depth = 1.5;  // just enough to seat the foot, not a structural pocket
foot_inset        = 10;   // distance from bottom-face edges to foot centers

// --- Print-friendliness ---
$fn = 64; // circle smoothness for previews/renders
