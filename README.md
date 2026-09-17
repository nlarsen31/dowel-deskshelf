# dowel-deskshelf

A parametric OpenSCAD design for a desk shelf: 3D-printed wall brackets on
each end hold wooden dowels that span wall-to-wall as the shelf surface.

## Status

First milestone: the wall brackets. Each bracket mounts flush to the wall
and has a bored socket that a dowel end presses/slides into. Dowel
placement and shelf-spanning geometry come later.

## Layout

```
scad/
  lib/params.scad   shared dimensions (dowel size, bracket size, screw holes)
  wall.scad         the wall bracket model
export/             generated STLs (gitignored, run `make` to produce)
```

## Building

Requires the [OpenSCAD](https://openscad.org/) CLI.

```
make          # render every scad/*.scad to export/*.stl
make wall     # render just the wall bracket
make clean    # remove generated STLs
```

Or render/preview directly:

```
openscad scad/wall.scad          # open in the OpenSCAD GUI
openscad -o export/wall.stl scad/wall.scad
```

## Tuning to your dowels and wall

Edit `scad/lib/params.scad`:

- `dowel_diameter` / `dowel_tolerance` — measure your actual dowel stock;
  tolerance controls press-fit vs. slide-fit.
- `dowel_bore_depth` — how far the dowel is captured inside the bracket.
- `wall_bracket_width/height/depth` — outer size of the printed block.
- `mount_hole_diameter/inset/count` — screw holes for securing to the wall.
