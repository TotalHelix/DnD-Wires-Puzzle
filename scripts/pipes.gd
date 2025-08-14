extends TileMapLayer

var mouse_held: bool = false
var tile_source_id: int
var finish_point: Vector2i

func _ready() -> void:
	# get the tile source id from the parent
	self.tile_source_id = self.get_parent().tile_source_id

func _input(event: InputEvent) -> void:
	
	# if we do a mouse thing
	if event is not InputEventMouse: return
	
	# the location in the tilemap layer of the player mouse
	var tilemap_coords: Vector2i = self.local_to_map(event.position)
	
	# if left click (press or release)
	if event is InputEventMouseButton and event.button_index == 1:
		
		# if left click is released, the mouse is always unclicked
		if not event.is_pressed():
			self.mouse_held = false
			return
		
		# if the mouse is hovering over a valid endpoint and left button is
		# pressed, the mouse now counts as dragging (pressed)
		var tile_texture: Vector2i = self.get_cell_atlas_coords(tilemap_coords)
		if tile_texture == Vector2i(1, 3) or tile_texture == Vector2i(0, 4) and event.is_pressed():
			self.mouse_held = true
			return
			
	# if mouse movement while dragging
	if event is InputEventMouseMotion and self.mouse_held:
		self.set_cell(tilemap_coords, tile_source_id, Vector2i(2, 3))
