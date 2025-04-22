class_name Diver
extends Node2D

@export var main_camera: Camera2D
@export var max_speed: float = 100;
@export var max_speed_distance: float = 100;
var move_diver: bool = false;
@onready var sprite: Sprite2D = $"Test-skydiver";
@export var end_game_sprite: Texture2D;

func _ready():
	if (main_camera == null):
		push_error("Camera not found. Connect it to diver!");
	
	
func _physics_process(delta: float) -> void:
	if (move_diver):
		var vector_towards_center = get_vector_towards_center();
		var sinus_speed_function = sin(min(max_speed_distance, get_vector_towards_center().length())/max_speed_distance * PI/2)
		var speed_modifier = max_speed * sinus_speed_function
		var modified_vector = vector_towards_center.normalized() * speed_modifier * delta;
		if (modified_vector != Vector2.ZERO):
			self.position += modified_vector;

func get_viewport_center() -> Vector2:
	var viewport_size = main_camera.get_viewport_rect().size * main_camera.zoom;
	return viewport_size/2 + main_camera.position;

func get_vector_towards_center():
	return -(self.position - get_viewport_center());

func position_at_center_of_viewport():
	print(get_viewport_center())
	self.position = get_viewport_center();
	
func set_parachute_out():
	sprite.texture = end_game_sprite;
	move_diver = false;
