extends Node

@export var main_node: Node
@export var main_camera: Camera2D
@export var background_image: Texture2D
var game_monitor_index: int


func _ready():
	if (!main_camera):
		main_camera = main_node.get_node("Camera2D");
		if (!main_camera):
			push_error("Camera not found. Connect it to window position manager!");
	
	game_monitor_index = DisplayServer.window_get_current_screen()

	create_and_place_background_image();
	
	main_camera.anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT


func create_and_place_background_image():
	# Setup background sprite to be the size of the screen, and put it in the main node.
	var background_sprite = Sprite2D.new();
	background_sprite.texture = background_image;
	# Size it to the screen size.
	background_sprite.scale = Vector2(DisplayServer.screen_get_size(game_monitor_index)) / background_image.get_size()
	background_sprite.centered = false;
	
	main_node.add_child.call_deferred(background_sprite)
	background_sprite.position = Vector2(0, 0);

func _process(delta):
	main_camera.position = DisplayServer.window_get_position(game_monitor_index)
