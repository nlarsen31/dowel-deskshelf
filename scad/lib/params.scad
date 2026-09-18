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
wall_bracket_height = 100;
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
// shelf_length = dowel_length - 2 * dowel_bore_depth + 2 * shelf_slot_depth; // total panel length, including the ends captured in each bracket's slot
shelf_length = 420;
shelf_width  = shelf_slot_w - shelf_width_clearance;

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
