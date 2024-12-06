extends Area2D

@onready var label: Label = $Label

@export var health = 10 

func _ready() -> void:
	label.text = "Health: " + str(health)

func _on_body_entered(body: Node2D) -> void:
	if body is DmgArea:
		print("hi")
		health -= 1
		print(health)
