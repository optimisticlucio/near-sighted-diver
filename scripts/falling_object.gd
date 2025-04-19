extends Node2D

@export var horizontal_speed: float = 0;
@export var falling_speed: float = 0;
@export var image: Texture2D;
@export var size: float = 0.5;
@export var degrees_to_spin_per_second: float = 0;

func _ready():
	get_node("Sprite2D").texture = image;
	self.scale = Vector2(size, size);

func _physics_process(delta):
	self.position += Vector2(horizontal_speed, falling_speed) * delta;
	self.rotation_degrees += degrees_to_spin_per_second * delta;
