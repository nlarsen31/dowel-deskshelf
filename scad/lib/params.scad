// Shared parameters for the dowel desk shelf.
// Units are mm throughout.

// --- Dowel ---
dowel_diameter   = 19.05; // 3/4" dowel, measure your actual stock
dowel_tolerance  = 0.3;   // added to bore diameter for a snug press/slide fit
dowel_bore_depth = 25;    // how far the dowel is captured inside the wall piece

// --- Wall bracket block ---
// "width" runs along the wall (left-right), "height" is vertical,
// "depth" is how far the block sticks out from the wall (front-back).
wall_bracket_width  = 40;
wall_bracket_height = 60;
wall_bracket_depth  = dowel_bore_depth + 10; // bore depth + material behind it

// --- Wall mounting screws ---
// Through-holes near the back face for screwing into a stud/anchor.
mount_hole_diameter = 5;     // clearance for a #10 / M5 screw
mount_hole_inset    = 8;     // distance from block edges to hole centers
mount_hole_count    = 2;     // vertical holes, evenly spaced

// --- Print-friendliness ---
$fn = 64; // circle smoothness for previews/renders
