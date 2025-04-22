extends Node2D

@onready var button: Button = $Button;
@export var game_manager: GameManager;

func _ready():
	button.pressed.connect(game_manager.start_game);
	button.pressed.connect(nuke_self);

func nuke_self():
	self.queue_free();
