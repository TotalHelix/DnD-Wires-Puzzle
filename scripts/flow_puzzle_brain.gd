@tool
extends Node2D

var tile_source_id: int = 5

@export_range(1, 34, 1) var puzzle_width:   int = 10:
	set(new_width):
		puzzle_width = new_width
		_call_update_puzzle()
		
@export_range(1, 18, 1) var puzzle_height:  int = 17:
	set(new_height):
		puzzle_height = new_height
		_call_update_puzzle()

func _call_update_puzzle() -> void:
	# find the puzzle bg
	for child in self.get_children():
		if child.is_in_group("background"):
			# we found the bg
			child.update_bg()
