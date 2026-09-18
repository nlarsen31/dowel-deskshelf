OPENSCAD ?= openscad
SRC_DIR  := scad
OUT_DIR  := export

SOURCES := $(wildcard $(SRC_DIR)/*.scad)
STLS    := $(patsubst $(SRC_DIR)/%.scad,$(OUT_DIR)/%.stl,$(SOURCES))

.PHONY: all clean wall wall_mirrored shelf

all: $(STLS)

$(OUT_DIR)/%.stl: $(SRC_DIR)/%.scad $(wildcard $(SRC_DIR)/lib/*.scad)
	@mkdir -p $(OUT_DIR)
	$(OPENSCAD) -o $@ $<

wall: $(OUT_DIR)/wall.stl
wall_mirrored: $(OUT_DIR)/wall_mirrored.stl
shelf: $(OUT_DIR)/shelf.stl

clean:
	rm -f $(OUT_DIR)/*.stl
