@tool
extends TileMapLayer

## the id of the time source that is used to draw the map
var tile_source_id: int

# size of the box to draw. The total w/h is including borders
var puzzle_width: int
var total_width: int
var puzzle_height: int
var total_height: int

# border position calculations
var top: int
var bottom: int
var left: int
var right: int

# sprits of the different tiles are in the order they appear, so in the sprite sheet it's
#	UL	U	UR
#	L	C	R
#	BL	B	BR

func update_bg() -> void:
	# should only be called once, so optimization isn't a huge concern
	
	# get the variables from the parent controller
	
	# tileset source id
	self.tile_source_id = self.get_parent().tile_source_id
	
	# size of the box to draw. The total w/h is including borders
	puzzle_width = self.get_parent().puzzle_width
	total_width = puzzle_width + 2
	puzzle_height = self.get_parent().puzzle_height
	total_height = puzzle_height + 2

	# border position calculations
	top 	= 0
	bottom 	= total_height - 1
	left 	= 0
	right 	= total_width - 1
	
	# first let's clear out the old
	self.clear()
	
	# for every tile on the grid (+ borders)
	for x: int in range(total_width):
		for y: int in range(total_height):
			# default texture is the main grid
			var atlas_coords: Vector2i = Vector2i(1, 1)
			
			match [x, y]:
				# check the corners first
				[left, top]: 	 atlas_coords = Vector2i(0, 0)
				[right, top]:	 atlas_coords = Vector2i(2, 0)
				[left, bottom]:	 atlas_coords = Vector2i(0, 2)
				[right, bottom]: atlas_coords = Vector2i(2, 2)
				
				# then check each side
				[_, top]:		 atlas_coords = Vector2i(1, 0)
				[_, bottom]:	 atlas_coords = Vector2i(1, 2)
				[left, _]:		 atlas_coords = Vector2i(0, 1)
				[right, _]:		 atlas_coords = Vector2i(2, 1)
			
			print("fill cell ", [x, y], " with sprite ", atlas_coords)
			self.set_cell(Vector2(x, y), tile_source_id, atlas_coords)

func _ready() -> void:
	update_bg()
	
