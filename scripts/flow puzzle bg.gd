@tool
extends TileMapLayer

## the id of the time source that is used to draw the map
var tile_source_id: int = 5

# size of the box to draw. The total w/h is including borders
@export var puzzle_width:   int = 10
var total_width: 			int = puzzle_width + 2
var total_width_minus_one:	int = total_width - 1
@export var puzzle_height:  int = 17
var total_height: 			int = puzzle_height + 2
var total_height_minus_one:	int = total_height - 1

# sprits of the different tiles are in the order they appear, so in the sprite sheet it's
#	UL	U	UR
#	L	C	R
#	BL	B	BR

func _ready() -> void:
	
	# for every tile on the grid (+ borders)
	for x in range(total_width):
		for y in range(total_height):
			var sprite_to_draw: Vector2i
			
			# left
			match Vector2i(x, y):
				# top row
				[0, 0]: sprite_to_draw = Vector2i(0, 0)
				[0, _]: sprite_to_draw = Vector2i(0, 1)
				[_, 0]: sprite_to_draw = Vector2i(1, 0)
				[total_width_minus_one, 0]: sprite_to_draw = Vector2i(2, 0)
				[0, total_height_minus_one]: sprite_to_draw = Vector2i(0, 2)
				[total_width_minus_one, total_height_minus_one]: sprite_to_draw = Vector2i(2, 2)
				
