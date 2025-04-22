class_name GameManager
extends Node

var game_active: bool = false # Whether or not the game is being played, or we're on a window.
@export var total_game_time: float = 10 # The time it takes to reach the bottom.
@export var diver: Diver;
@export var object_summon_frequency: float = .2; # How many seconds for stuff to be summoned.
@export var camera: Camera2D;
var total_time_passed: float = 0; # The amount of time passed in this game.
var scroll_speed: float; # Calculated based on the total game time and screen size; the pixels to scroll every second.
var background_image: Sprite2D;
var objects_on_screen: Array[FallingObject];
var deletion_threshold_top: float = 0;
var deletion_threshold_bottom: float = 800;
@export var deletion_threshold_lenience = 200;

func _ready() -> void:
	deletion_threshold_bottom = DisplayServer.screen_get_size(DisplayServer.window_get_current_screen()).y;
	
	deletion_threshold_bottom += deletion_threshold_lenience;
	deletion_threshold_top -= deletion_threshold_lenience;

func _physics_process(delta):
	if (game_active):
		
		total_time_passed += delta;
		
		clean_up_objects();
		
		if (background_image):
			background_image.position += Vector2(0, -scroll_speed * delta)
			deletion_threshold_top += -scroll_speed * delta
			deletion_threshold_bottom += -scroll_speed * delta
		
		if (total_time_passed >= total_game_time):
			end_game()
	
func set_background_image(image: Sprite2D):
	self.background_image = image;
	
	scroll_speed = (self.background_image.texture.get_height() * self.background_image.scale.y - DisplayServer.screen_get_size(DisplayServer.window_get_current_screen()).y) / (total_game_time);

func start_game():
	diver.position = camera.position + Vector2(get_viewport().size.x/2, -50);
	diver.move_diver = true;
	game_active = true;

func end_game():
	diver.set_parachute_out();
	game_active = false;

func clean_up_objects():
	for falling_object in objects_on_screen:
		var object_y = falling_object.position.y
		if (object_y < deletion_threshold_top or object_y > deletion_threshold_bottom):
			falling_object.queue_free()

func restart_game():
	get_tree().reload_current_scene()
