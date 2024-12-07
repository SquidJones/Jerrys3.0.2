class_name MainMenu
extends Control

@onready var start: Button = $MarginContainer/GridContainer/Start as Button
@onready var exit: Button = $MarginContainer/GridContainer/Exit as Button

	
func _ready() -> void:
	exit.button_down.connect(on_exit_pressed)
		
	
func on_exit_pressed() -> void:
	get_tree().quit()


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
