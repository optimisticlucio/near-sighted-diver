extends Node2D


func set_button_function(input_function):
	get_node("Button").pressed.connect(input_function);
