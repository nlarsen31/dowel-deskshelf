# dowel-deskshelf

A parametric OpenSCAD design for a desk shelf: 3D-printed wall brackets on
each end hold wooden dowels that span wall-to-wall as the shelf surface.

## Status

First milestone: the wall brackets. Each bracket sits flush to the wall
and has a row of bored sockets that dowel ends press/slide into. How the
bracket actually attaches to the wall comes later.

## Layout

```
scad/
  lib/params.scad   shared dimensions (dowel size, bracket size, dowel row)
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

## Versions

A rendered image of each meaningful revision is kept under `docs/images/`
for a visual record of how the design evolved.

### v0

Wall bracket: 6-dowel row along the top edge, rounded corners, filleted
dowel bore openings, rubber foot recesses on the bottom face.

![v0](docs/images/v0.png)

## Tuning to your dowels and wall

Edit `scad/lib/params.scad`:

- `dowel_diameter_in` / `dowel_tolerance` — set to your actual dowel stock
  (inches); tolerance controls press-fit vs. slide-fit.
- `dowel_bore_depth` — how far the dowel is captured inside the bracket.
- `num_dowels` — how many dowels the bracket holds.
- `dowel_min_wall` / `dowel_edge_margin` — plastic left between/around the
  dowel bores; `wall_bracket_width` is derived from these automatically.
- `wall_bracket_height/depth` — outer size of the printed block.
