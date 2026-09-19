OPENSCAD ?= openscad
SRC_DIR  := scad
OUT_DIR  := export

SOURCES := $(wildcard $(SRC_DIR)/*.scad)
STLS    := $(patsubst $(SRC_DIR)/%.scad,$(OUT_DIR)/%.stl,$(SOURCES))

.PHONY: all clean wall wall_mirrored shelf tray wall_through wall_through_mirrored half_shelf

all: $(STLS)

$(OUT_DIR)/%.stl: $(SRC_DIR)/%.scad $(wildcard $(SRC_DIR)/lib/*.scad)
	@mkdir -p $(OUT_DIR)
	$(OPENSCAD) -o $@ $<

wall: $(OUT_DIR)/wall.stl
wall_mirrored: $(OUT_DIR)/wall_mirrored.stl
shelf: $(OUT_DIR)/shelf.stl
tray: $(OUT_DIR)/tray.stl
wall_through: $(OUT_DIR)/wall_through.stl
wall_through_mirrored: $(OUT_DIR)/wall_through_mirrored.stl
half_shelf: $(OUT_DIR)/half_shelf.stl

clean:
	rm -f $(OUT_DIR)/*.stl
