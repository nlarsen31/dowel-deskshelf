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

// --- Dowel row (top edge of the wall bracket) ---
num_dowels        = 6;
dowel_min_wall    = 6;    // min plastic left between adjacent dowel bores
dowel_edge_margin = 10;   // plastic left outboard of the first/last dowel
dowel_row_offset  = 15;   // distance from the top edge down to the hole row

dowel_bore_d   = dowel_diameter + dowel_tolerance;
dowel_spacing  = dowel_bore_d + dowel_min_wall; // center-to-center

// --- Wall bracket block ---
// "width" runs along the wall (left-right), "height" is vertical,
// "depth" is how far the block sticks out from the wall (front-back).
// Width is derived so all dowels fit with the margins/spacing above.
wall_bracket_width  = (num_dowels - 1) * dowel_spacing + dowel_bore_d + 2 * dowel_edge_margin;
wall_bracket_height = 80;
wall_bracket_depth  = dowel_bore_depth + 10; // bore depth + material behind it
corner_radius       = 4; // fillet radius on all 12 edges of the block

// --- Rubber feet ---
// Shallow recesses in the bottom face (Z=0) so self-adhesive rubber feet
// sit flush, one near each of the four bottom corners.
foot_diameter_in  = 0.4;
foot_diameter     = in_to_mm(foot_diameter_in);
foot_recess_depth = 1.5;  // just enough to seat the foot, not a structural pocket
foot_inset        = 10;   // distance from bottom-face edges to foot centers

// --- Print-friendliness ---
$fn = 64; // circle smoothness for previews/renders
